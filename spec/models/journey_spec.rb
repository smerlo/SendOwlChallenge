# frozen_string_literal: true

# == Schema Information
#
# Table name: journeys
#
#  id               :bigint           not null, primary key
#  card_id          :bigint
#  start_station_id :bigint
#  end_station_id   :bigint
#  bus_journey      :boolean          default(FALSE), not null
#  completed        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_journeys_on_card_id           (card_id)
#  index_journeys_on_end_station_id    (end_station_id)
#  index_journeys_on_start_station_id  (start_station_id)
#
require 'rails_helper'

RSpec.describe Journey do
  subject { build(:journey) }

  it { is_expected.to belong_to(:card) }
  it { is_expected.to belong_to(:start_station).class_name('Station').optional }
  it { is_expected.to belong_to(:end_station).class_name('Station').optional }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it 'belongs to a card' do
      card = create(:card)
      journey = create(:journey, card:)
      expect(journey.card).to eq(card)
    end

    it 'belongs to a start station' do
      station = create(:station)
      journey = create(:journey, start_station: station)
      expect(journey.start_station).to eq(station)
    end

    it 'can belong to an end station' do
      station = create(:station)
      journey = create(:journey, end_station: station)
      expect(journey.end_station).to eq(station)
    end
  end
end
