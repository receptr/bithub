class CreatePayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :payouts do |t|
      t.string :bitcoin_address, null: false
      t.decimal :amount, precision: 15, scale: 10, null: false

      t.datetime :released_at
      t.references :released_by

      t.references :merge, null: false

      t.timestamps
    end
  end
end
