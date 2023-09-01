# frozen_string_literal: true

class CreateStations < ActiveRecord::Migration[7.0]
  def change
    create_table :stations do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
