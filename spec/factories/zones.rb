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
FactoryBot.define do
  factory :zone do
    number { Faker::Number.between(from: 1, to: 3) }
  end
end
