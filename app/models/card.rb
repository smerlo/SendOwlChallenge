# frozen_string_literal: true

# == Schema Information
#
# Table name: cards
#
#  id         :bigint           not null, primary key
#  balance    :decimal(, )      default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Card < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :journeys, dependent: :destroy

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def charge(amount)
    update!(balance: balance - amount)
    transactions.create!(amount: -amount, description: 'Travel charge')
  end

  def add_balance(amount)
    update!(balance: balance + amount)
    transactions.create!(amount:, description: 'Top up')
  end
end
