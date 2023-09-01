# frozen_string_literal: true

# == Schema Information
#
# Table name: fares
#
#  id         :bigint           not null, primary key
#  fare_type  :string           not null
#  amount     :decimal(5, 2)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_fares_on_fare_type  (fare_type) UNIQUE
#
class Fare < ApplicationRecord
  enum fare_type: {
    zone_1: 'zone_1',
    one_zone_outside_zone_1: 'one_zone_outside_zone_1',
    two_zones_including_zone_1: 'two_zones_including_zone_1',
    two_zones_excluding_zone_1: 'two_zones_excluding_zone_1',
    three_zones: 'three_zones',
    bus_journey: 'bus_journey'
  }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fare_type, presence: true, uniqueness: { case_sensitive: true }
end
