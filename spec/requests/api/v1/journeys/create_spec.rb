# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Journeys' do
  describe 'POST /create' do
    subject { post api_v1_journeys_path, params: }

    let(:card) { create(:card) }
    let!(:station) { create(:station) }
    let!(:fare) { create(:fare, amount: 30.0) }
    let!(:bus_fare) { create(:fare, fare_type: 'bus_journey', amount: 3.0) }

    context 'when card exists' do
      context 'when it is a bus journey' do
        let(:params) { { card_number: card.id, bus_journey: true } }

        it 'charges for bus journey' do
          subject
          expect(response).to have_http_status(:created)
        end
      end

      context 'when it is a train journey' do
        let(:params) { { card_number: card.id, start_station_id: station.id } }

        it 'charges the max fare' do
          expect_any_instance_of(FareChargerService).to receive(:charge_max)
          subject
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'when card does not exist' do
      let(:params) { { card_number: 'non_existent' } }

      it 'returns not found error' do
        expect {
          subject
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
