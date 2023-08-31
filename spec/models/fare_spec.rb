# frozen_string_literal: true

# == Schema Information
#
# Table name: fares
#
#  id         :bigint           not null, primary key
#  fare_type  :string           not null
#  amount     :decimal(5, 2)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_fares_on_fare_type  (fare_type) UNIQUE
#
require 'rails_helper'

RSpec.describe Fare do
  subject { build(:fare) }

  it { is_expected.to validate_presence_of(:fare_type) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
