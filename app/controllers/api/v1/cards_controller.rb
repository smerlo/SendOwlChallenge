# frozen_string_literal: true

module Api
  module V1
    class CardsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_card, only: [:add_balance]

      def add_balance
        amount_to_add = params[:amount].to_f
        if amount_to_add.positive?
          @card.add_balance(amount_to_add, 'New balance deposit')
          render json: { message: 'Balance added successfully', balance: @card.balance }
        else
          render json: { error: 'Amount must be greater than 0' }, status: :unprocessable_entity
        end
      end

      private

      def find_card
        @card = Card.find(params[:id])
      end
    end
  end
end
