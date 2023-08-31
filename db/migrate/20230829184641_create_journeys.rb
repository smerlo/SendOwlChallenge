# frozen_string_literal: true

class CreateJourneys < ActiveRecord::Migration[7.0]
  def change
    create_table :journeys do |t|
      t.references :card, foreign_key: true
      t.references :start_station, foreign_key: { to_table: :stations }
      t.references :end_station, foreign_key: { to_table: :stations }
      t.boolean :bus_journey, default: false, null: false
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end
