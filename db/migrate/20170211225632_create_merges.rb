class CreateMerges < ActiveRecord::Migration[5.0]
  def change
    create_table :merges do |t|
      t.jsonb :payload, null: false

      t.references :author, null: false
      t.references :merger, null: false

      t.timestamps
    end
  end
end
