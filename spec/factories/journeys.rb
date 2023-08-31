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
FactoryBot.define do
  factory :journey do
    card
    start_station { create(:station) }
    end_station { create(:station) }
  end
end
