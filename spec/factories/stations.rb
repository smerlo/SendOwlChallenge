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
FactoryBot.define do
  factory :station do
    name { Faker::Address.unique.city }
  end
end
