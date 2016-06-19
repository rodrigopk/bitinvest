# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160619134303) do

  create_table "coins", force: :cascade do |t|
    t.string   "name"
    t.string   "symbol"
    t.float    "value"
    t.float    "volume"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "is_fiat",          default: false
    t.text     "variations"
    t.float    "market_cap"
    t.float    "available_supply"
    t.string   "tag"
  end

  add_index "coins", ["tag"], name: "index_coins_on_tag", unique: true

  create_table "transactions", force: :cascade do |t|
    t.float    "units"
    t.integer  "wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["wallet_id", "created_at"], name: "index_transactions_on_wallet_id_and_created_at"
  add_index "transactions", ["wallet_id"], name: "index_transactions_on_wallet_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "wallets", force: :cascade do |t|
    t.float    "units"
    t.integer  "user_id"
    t.integer  "coin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wallets", ["coin_id"], name: "index_wallets_on_coin_id"
  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id"

end
