# frozen_string_literal: true

class FareChargerService
  def initialize(card)
    @card = card
  end

  def charge_max
    max_fare = Fare.maximum(:amount)
    @card.balance -= max_fare
    @card.transactions.create!(amount: -max_fare, description: 'Charge for max fare')
    @card.save!
  end

  def charge_bus_journey
    amount = Fare.where(fare_type: 'bus_journey').first&.amount
    @card.balance -= amount
    @card.transactions.create!(amount: -amount, description: 'Charge for bus journey')
    @card.save!
  end
end
