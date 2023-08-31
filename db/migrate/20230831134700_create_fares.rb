# frozen_string_literal: true

class CreateFares < ActiveRecord::Migration[7.0]
  def change
    create_table :fares do |t|
      t.string :fare_type, null: false
      t.decimal :amount, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end
