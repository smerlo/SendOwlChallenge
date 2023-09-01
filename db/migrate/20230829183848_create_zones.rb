# frozen_string_literal: true

class CreateZones < ActiveRecord::Migration[7.0]
  def change
    create_table :zones do |t|
      t.integer :number, null: false, unique: true
      t.timestamps
    end
  end
end
