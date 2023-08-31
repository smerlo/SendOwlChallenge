# frozen_string_literal: true

class FareCalculatorService
  attr_reader :journey

  def initialize(journey)
    @journey = journey
  end

  def calculate
    return Fare.bus_journey.first.amount if journey.bus_journey?

    # journey.preload(start_station: :zones, end_station: :zones)
    calculate_train_fare
  end

  private

  def calculate_train_fare
    case journey_zones_count
    when 1
      single_zone_fare
    when 2
      two_zone_fare
    when 3
      three_zone_fare
    end
  end

  def single_zone_fare
    return Fare.zone_1.first.amount if includes_zone_1?

    [Fare.one_zone_outside_zone_1.first.amount, Fare.zone_1.first.amount].min
  end

  def two_zone_fare
    return two_zones_including_zone_1_fare if includes_zone_1?

    two_zones_excluding_zone_1_fare
  end

  def two_zones_including_zone_1_fare
    [Fare.two_zones_including_zone_1.first.amount, Fare.zone_1.first.amount].min
  end

  def two_zones_excluding_zone_1_fare
    [Fare.two_zones_excluding_zone_1.first.amount, Fare.one_zone_outside_zone_1.first.amount,
     Fare.zone_1.first.amount].min
  end

  def three_zone_fare
    Fare.three_zones.first.amount
  end

  def journey_zones_count
    start_zone_number = journey.start_station.zones.minimum(:number)
    end_zone_number = journey.end_station.zones.maximum(:number)

    total_zones = (start_zone_number..end_zone_number).to_a

    total_zones.count
  end

  def includes_zone_1?
    start_zones = journey.start_station.zones if journey.start_station
    end_zones = journey.end_station.zones if journey.end_station
    (start_zones + end_zones).any? { |zone| zone.number == 1 }
  end
end
