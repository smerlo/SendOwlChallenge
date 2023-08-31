# frozen_string_literal: true

module Api
  module V1
    class JourneysController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        card = find_card
        unless card
          render(json: { error: 'Card not found' }, status: :not_found)
          return
        end

        journey = build_journey(card)
        charge_for_journey(card, journey)

        if journey.save
          render json: journey.card, status: :created
        else
          render json: journey.errors, status: :unprocessable_entity
        end
      end

      def update
        card = find_card
        unless card
          render(json: { error: 'Card not found' }, status: :not_found)
          return
        end
        journey = find_ongoing_journey(card)
        return unless journey

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
        Card.find_by(id: params[:card_number])
      end

      def build_journey(card)
        if params[:bus_journey] && params[:bus_journey] == 'true'
          card.journeys.build(bus_journey: true, completed: true)
        else
          card.journeys.build(start_station_id: params[:start_station_id], bus_journey: false)
        end
      end

      def charge_for_journey(card, journey)
        if journey.bus_journey
          FareChargerService.new(card).charge_bus_journey
        else
          FareChargerService.new(card).charge_max
        end
      end

      def find_ongoing_journey(card)
        journey = card.journeys.where(completed: false).last
        render(json: { error: 'No ongoing journey found for this card' }, status: :not_found) unless journey
        journey
      end

      def complete_journey(journey)
        journey.end_station_id = params[:end_station_id]
        journey.completed = true
      end
    end
  end
end
