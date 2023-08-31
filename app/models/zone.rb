# frozen_string_literal: true

# == Schema Information
#
# Table name: zones
#
#  id         :bigint           not null, primary key
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_zones_on_number  (number) UNIQUE
#
class Zone < ApplicationRecord
  has_many :zone_stations, dependent: :destroy
  has_many :stations, through: :zone_stations

  validates :number, presence: true, uniqueness: true
end
