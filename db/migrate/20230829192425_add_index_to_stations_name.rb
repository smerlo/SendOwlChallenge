# frozen_string_literal: true

class AddIndexToStationsName < ActiveRecord::Migration[7.0]
  def change
    add_index :stations, :name, unique: true
  end
end
