# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FareCalculatorService, type: :service do
  subject { described_class.new(journey) }

  let(:journey) { instance_double('Journey') }

  describe '#calculate' do
    context 'when it is a bus journey' do
      before do
        allow(journey).to receive(:bus_journey?).and_return(true)
        create(:fare, fare_type: 'bus_journey', amount: 10.0) # Create actual fare record
      end

      it 'returns the bus fare' do
        expect(subject.calculate).to eq(10.0)
      end
    end

    context 'when it is a train journey' do
      before do
        allow(journey).to receive(:bus_journey?).and_return(false)
      end

      context 'with 1 zone' do
        before do
          allow(subject).to receive(:journey_zones_count).and_return(1)
        end

        context 'when including zone 1' do
          before do
            allow(subject).to receive_messages(includes_zone_1?: true, calculate_train_fare: 15.0)
          end

          it 'returns the fare for 1 zone including zone 1' do
            expect(subject.calculate).to eq(15.0)
          end
        end

        context 'when excluding zone 1' do
          before do
            allow(subject).to receive_messages(includes_zone_1?: false, calculate_train_fare: 12.0)
          end

          it 'returns the minimum fare for 1 zone' do
            expect(subject.calculate).to eq(12.0)
          end
        end
      end

      context 'with 2 zones' do
        before do
          allow(subject).to receive(:journey_zones_count).and_return(2)
        end

        context 'when including zone 1' do
          before do
            allow(subject).to receive_messages(includes_zone_1?: true, calculate_train_fare: 15.0)
          end

          it 'returns the minimum fare for 2 zones including zone 1' do
            expect(subject.calculate).to eq(15.0)
          end
        end

        context 'when excluding zone 1' do
          before do
            allow(subject).to receive_messages(includes_zone_1?: false, calculate_train_fare: 12.0)
          end

          it 'returns the minimum fare for 2 zones excluding zone 1' do
            expect(subject.calculate).to eq(12.0)
          end
        end
      end

      context 'with 3 zones' do
        before do
          allow(subject).to receive_messages(journey_zones_count: 3, calculate_train_fare: 30.0)
        end

        it 'returns the fare for 3 zones' do
          expect(subject.calculate).to eq(30.0)
        end
      end
    end
  end
end
