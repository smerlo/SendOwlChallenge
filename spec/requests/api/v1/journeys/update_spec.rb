# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Journeys' do
  describe 'PUT /update/:card_number' do
    subject { put api_v1_journeys_path(card_number: card.id), params: }

    let!(:card) { create(:card) }
    let!(:zone) { create(:zone, number: 1) }
    let!(:start_station) { create(:station, zones: [zone]) }
    let!(:end_station) { create(:station, zones: [zone]) }
    let!(:fare) { create(:fare, fare_type: 'zone_1', amount: 30.0) }
    let!(:journey) { create(:journey, card:, start_station:, completed: false) }

    context 'when card exists' do
      let(:params) { { end_station_id: end_station.id } }

      it 'completes the journey' do
        subject
        expect(journey.reload.completed).to be true
      end

      it 'processes the refund' do
        expect_any_instance_of(RefundCalculatorService).to receive(:process_refund)
        subject
      end
    end

    context 'when card does not exist' do
      subject { put api_v1_journeys_path(card_number: 'non_existent') }

      it 'returns not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when journey does not exist' do
      before { journey.destroy }

      let(:params) { { end_station_id: 1 } }

      it 'returns not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
