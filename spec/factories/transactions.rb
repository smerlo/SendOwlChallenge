# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id          :bigint           not null, primary key
#  amount      :decimal(, )
#  description :string
#  card_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_transactions_on_card_id  (card_id)
#
FactoryBot.define do
  factory :transaction do
    card
    amount { Faker::Number.between(from: -10, to: 10) }
    description { Faker::Lorem.sentence }
  end
end
