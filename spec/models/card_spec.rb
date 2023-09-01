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
require 'rails_helper'

RSpec.describe Card do
  subject { build(:card) }

  it { is_expected.to have_many(:transactions).dependent(:destroy) }
  it { is_expected.to have_many(:journeys) }

  it { is_expected.to validate_presence_of(:balance) }
  it { is_expected.to validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }

  describe 'associations' do
    let(:transaction) { create(:transaction, card: subject) }
    let(:journey) { create(:journey, card: subject) }

    it 'has transactions' do
      expect(subject.transactions).to include(transaction)
    end

    it 'has journeys' do
      expect(subject.journeys).to include(journey)
    end
  end

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
