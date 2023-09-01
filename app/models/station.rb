# frozen_string_literal: true

# == Schema Information
#
# Table name: stations
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stations_on_name  (name) UNIQUE
#
class Station < ApplicationRecord
  has_many :zone_stations, dependent: :destroy
  has_many :zones, through: :zone_stations

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
