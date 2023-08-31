# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.decimal :balance, default: 0.0, null: false

      t.timestamps
    end
  end
end
