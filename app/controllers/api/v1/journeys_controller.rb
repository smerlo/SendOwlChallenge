# frozen_string_literal: true

module Api
  module V1
    class JourneysController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_card, only: %i[create update]

      def create
        journey = build_journey(@card)
        charge_for_journey(@card, journey)

        if journey.save
          render json: journey.card, status: :created
        else
          render json: journey.errors, status: :unprocessable_entity
        end
      end

      def update
        journey = find_ongoing_journey(@card)

        return render_not_found_journey if journey.blank?

        complete_journey(journey)

        if journey.save
          RefundCalculatorService.new(journey).process_refund
          render json: journey.card
        else
          render json: journey.errors, status: :unprocessable_entity
        end
      end

      private

      def find_card
        @card = Card.find(params[:card_number])
      end

      def build_journey(card)
        if params[:bus_journey] == 'true'
          card.journeys.build(bus_journey: true, completed: true)
        else
          card.journeys.build(start_station_id: params[:start_station_id], bus_journey: false)
        end
      end

      def charge_for_journey(card, journey)
        FareChargerService.new(card).charge_journey(journey)
      end

      def find_ongoing_journey(card)
        card.journeys.ongoing_journey(card.id)
      end

      def complete_journey(journey)
        journey.end_station_id = params[:end_station_id]
        journey.completed = true
      end

      def render_not_found_journey
        render(json: { error: 'Journey not found' }, status: :not_found)
      end
    end
  end
end
