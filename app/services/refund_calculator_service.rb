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

    @card.add_balance(difference, 'Refund for journey')
  end
end
