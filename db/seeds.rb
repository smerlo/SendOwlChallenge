# frozen_string_literal: true

AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

Fare.delete_all

Fare.create!(fare_type: 'zone_1', amount: 2.50)
Fare.create!(fare_type: 'one_zone_outside_zone_1', amount: 2.00)
Fare.create!(fare_type: 'two_zones_including_zone_1', amount: 3.00)
Fare.create!(fare_type: 'two_zones_excluding_zone_1', amount: 2.25)
Fare.create!(fare_type: 'three_zones', amount: 3.20)
Fare.create!(fare_type: 'bus_journey', amount: 1.80)

Card.create!(balance: 30)

stations_data = [
  { name: 'Holburn', zones: [1] },
  { name: 'Chelsea', zones: [1] },
  { name: 'Earl’s Court', zones: [1, 2] },
  { name: 'Wimbledon', zones: [3] },
  { name: 'Hammersmith', zones: [2] }
]

stations_data.each do |station_data|
  station = Station.find_or_create_by!(name: station_data[:name])
  station_data[:zones].each do |zone_number|
    zone = Zone.find_or_create_by!(number: zone_number)
    station.zones << zone unless station.zones.include?(zone)
  end
end
