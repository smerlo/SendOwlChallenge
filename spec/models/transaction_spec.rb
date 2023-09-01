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
require 'rails_helper'

RSpec.describe Transaction do
  subject { build(:transaction) }

  it { is_expected.to belong_to(:card) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount) }
  it { is_expected.to validate_presence_of(:description) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it 'belongs to a card' do
      card = create(:card)
      transaction = create(:transaction, card:)
      expect(transaction.card).to eq(card)
    end
  end
end
