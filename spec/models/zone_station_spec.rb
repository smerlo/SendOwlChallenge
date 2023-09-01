# frozen_string_literal: true

# == Schema Information
#
# Table name: zone_stations
#
#  id         :bigint           not null, primary key
#  station_id :bigint           not null
#  zone_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_zone_stations_on_station_id              (station_id)
#  index_zone_stations_on_station_id_and_zone_id  (station_id,zone_id) UNIQUE
#  index_zone_stations_on_zone_id                 (zone_id)
#
require 'rails_helper'

RSpec.describe ZoneStation do
  subject { build(:zone_station) }

  it { is_expected.to belong_to(:zone) }
  it { is_expected.to belong_to(:station) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it 'belongs to a zone' do
      zone = create(:zone)
      zone_station = create(:zone_station, zone:)
      expect(zone_station.zone).to eq(zone)
    end

    it 'belongs to a station' do
      station = create(:station)
      zone_station = create(:zone_station, station:)
      expect(zone_station.station).to eq(station)
    end
  end
end
