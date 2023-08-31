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
class Transaction < ApplicationRecord
  belongs_to :card

  validates :amount, presence: true
  validates :amount, numericality: true
  validates :description, presence: true
end
