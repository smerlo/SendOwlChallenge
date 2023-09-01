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
require 'rails_helper'

RSpec.describe Station do
  subject { build(:station) }

  it { is_expected.to have_many(:zone_stations).dependent(:destroy) }
  it { is_expected.to have_many(:zones).through(:zone_stations) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
