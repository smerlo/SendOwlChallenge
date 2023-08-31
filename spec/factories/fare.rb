# frozen_string_literal: true

FactoryBot.define do
  factory :fare do
    fare_type { 'zone_1' }
    amount { 2.50 }
  end
end
