# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefundCalculatorService, type: :service do
  let(:card) { create(:card) }
  let(:journey) { create(:journey, card:) }
  let(:service) { described_class.new(journey) }

  before do
    create(:fare, fare_type: 'three_zones', amount: 50.0)
    create(:fare, fare_type: 'bus_journey', amount: 30.0)
  end

  describe '#process_refund' do
    context 'when the real fare is less than the maximum fare' do
      before do
        allow_any_instance_of(FareCalculatorService).to receive(:calculate).and_return(30.0)
      end

      it 'creates a transaction for the refund' do
        expect {
          service.process_refund
        }.to change { card.transactions.count }.by(1)

        transaction = card.transactions.last
        expect(transaction.amount).to eq(20.0)
        expect(transaction.description).to eq('Refund for journey')
      end

      it 'adds the refund difference to the card balance' do
        expect {
          service.process_refund
        }.to change { card.reload.balance }.by(20.0)
      end
    end

    context 'when the real fare is equal to or greater than the maximum fare' do
      before do
        allow_any_instance_of(FareCalculatorService).to receive(:calculate).and_return(50.0)
      end

      it 'does not create a transaction' do
        expect {
          service.process_refund
        }.not_to change { card.transactions.count }
      end

      it 'does not change the card balance' do
        expect {
          service.process_refund
        }.not_to change { card.reload.balance }
      end
    end
  end
end
