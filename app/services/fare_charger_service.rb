# frozen_string_literal: true

class FareChargerService
  def initialize(card)
    @card = card
  end

  def charge_journey(journey)
    if journey.bus_journey
      charge_bus_journey
    else
      charge_max
    end
  end

  def charge_max
    max_fare = Fare.maximum(:amount)
    @card.charge(max_fare, 'Charge for max fare')
  end

  def charge_bus_journey
    amount = Fare.where(fare_type: 'bus_journey').first&.amount
    @card.charge(amount, 'Charge for bus journey')
  end
end
