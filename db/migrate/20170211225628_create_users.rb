class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :users do |t|
      t.citext :github_username, null: false, index: { unique: true }
      t.string :bitcoin_address
      t.datetime :adminified_at

      t.timestamps
    end
  end
end
