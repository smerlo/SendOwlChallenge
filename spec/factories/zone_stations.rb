# frozen_string_literal: true

# == Schema Information
#
# Table name: zone_stations
#
#  id         :bigint           not null, primary key
#  station_id :bigint           not null
#  zone_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_zone_stations_on_station_id              (station_id)
#  index_zone_stations_on_station_id_and_zone_id  (station_id,zone_id) UNIQUE
#  index_zone_stations_on_zone_id                 (zone_id)
#
FactoryBot.define do
  factory :zone_station do
    zone
    station
  end
end
