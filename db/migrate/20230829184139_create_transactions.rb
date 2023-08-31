# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :description
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
