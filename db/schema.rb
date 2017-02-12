# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170211234452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "approvals", force: :cascade do |t|
    t.integer  "payout_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payout_id"], name: "index_approvals_on_payout_id", using: :btree
    t.index ["user_id"], name: "index_approvals_on_user_id", using: :btree
  end

  create_table "merges", force: :cascade do |t|
    t.jsonb    "payload",    null: false
    t.integer  "author_id",  null: false
    t.integer  "merger_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_merges_on_author_id", using: :btree
    t.index ["merger_id"], name: "index_merges_on_merger_id", using: :btree
  end

  create_table "payouts", force: :cascade do |t|
    t.string   "bitcoin_address",                           null: false
    t.decimal  "amount",          precision: 15, scale: 10, null: false
    t.datetime "released_at"
    t.integer  "released_by_id"
    t.integer  "merge_id",                                  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["merge_id"], name: "index_payouts_on_merge_id", using: :btree
    t.index ["released_by_id"], name: "index_payouts_on_released_by_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.citext   "github_username", null: false
    t.string   "bitcoin_address"
    t.datetime "adminified_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["github_username"], name: "index_users_on_github_username", unique: true, using: :btree
  end

end
