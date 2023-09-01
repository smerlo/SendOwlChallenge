# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FareChargerService, type: :service do
  let(:card) { create(:card, balance: 100) }
  let(:service) { described_class.new(card) }

  before do
    create(:fare, fare_type: 'three_zones', amount: 50.0)
    create(:fare, fare_type: 'bus_journey', amount: 30.0)
  end

  describe '#charge_max' do
    it 'creates a transaction for the maximum fare' do
      expect {
        service.charge_max
      }.to change { card.transactions.count }.by(1)

      transaction = card.transactions.last
      expect(transaction.amount).to eq(-50.0)
      expect(transaction.description).to eq('Charge for max fare')
    end

    it 'deducts the maximum fare from the card' do
      expect {
        service.charge_max
      }.to change { card.reload.balance }.by(-50.0)
    end
  end

  describe '#charge_bus_journey' do
    it 'creates a transaction for the bus journey fare' do
      expect {
        service.charge_bus_journey
      }.to change { card.transactions.count }.by(1)

      transaction = card.transactions.last
      expect(transaction.amount).to eq(-30.0)
      expect(transaction.description).to eq('Charge for bus journey')
    end

    it 'deducts the bus journey fare from the card' do
      expect {
        service.charge_bus_journey
      }.to change { card.reload.balance }.by(-30.0)
    end
  end
end
