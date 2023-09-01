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
require 'rails_helper'

RSpec.describe Zone do
  subject { build(:zone) }

  it { is_expected.to have_many(:zone_stations).dependent(:destroy) }
  it { is_expected.to have_many(:stations).through(:zone_stations) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
