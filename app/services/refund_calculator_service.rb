# frozen_string_literal: true

class RefundCalculatorService
  def initialize(journey)
    @journey = journey

    @card = journey.card
  end

  def process_refund
    real_fare = FareCalculatorService.new(@journey).calculate
    difference = Fare.maximum(:amount) - real_fare

    return if difference <= 0

    @card.balance += difference

    @card.transactions.create!(amount: difference, description: 'Refund for journey')
    @card.save!
  end
end
