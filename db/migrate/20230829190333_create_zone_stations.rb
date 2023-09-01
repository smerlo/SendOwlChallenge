# frozen_string_literal: true

class CreateZoneStations < ActiveRecord::Migration[7.0]
  def change
    create_table :zone_stations do |t|
      t.references :station, null: false, foreign_key: true
      t.references :zone, null: false, foreign_key: true
      t.timestamps
    end

    add_index :zone_stations, %i[station_id zone_id], unique: true
  end
end
