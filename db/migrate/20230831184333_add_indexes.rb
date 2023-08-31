# frozen_string_literal: true

class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :fares, :fare_type, unique: true
    add_index :zones, :number, unique: true
  end
end
