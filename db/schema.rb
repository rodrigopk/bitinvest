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

ActiveRecord::Schema.define(version: 20160731122832) do

  create_table "answers", force: :cascade do |t|
    t.string   "text"
    t.boolean  "correct"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "coin_average_statistics", force: :cascade do |t|
    t.integer  "coin_id"
    t.float    "total_volume"
    t.float    "total_operations"
    t.float    "total_coin_views"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "coin_average_statistics", ["coin_id"], name: "index_coin_average_statistics_on_coin_id"

  create_table "coin_metrics", force: :cascade do |t|
    t.decimal  "value",      default: 0.0
    t.decimal  "variation",  default: 0.0
    t.integer  "coin_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "coin_metrics", ["coin_id"], name: "index_coin_metrics_on_coin_id"

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
    t.integer  "rank"
  end

  add_index "coins", ["tag"], name: "index_coins_on_tag", unique: true

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "right_answers"
    t.integer  "wrong_answers"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.boolean  "correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "quizzes", ["question_id"], name: "index_quizzes_on_question_id"
  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id"

  create_table "transactions", force: :cascade do |t|
    t.float    "units"
    t.integer  "wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["wallet_id", "created_at"], name: "index_transactions_on_wallet_id_and_created_at"
  add_index "transactions", ["wallet_id"], name: "index_transactions_on_wallet_id"

  create_table "user_metrics", force: :cascade do |t|
    t.decimal  "wallet_value", default: 0.0
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_metrics", ["user_id"], name: "index_user_metrics_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.float    "daily_volume"
    t.float    "daily_transactions"
    t.float    "daily_wallet_views"
    t.decimal  "value_last_1h",           default: 0.0
    t.decimal  "value_last_24h",          default: 0.0
    t.decimal  "value_var_1h",            default: 0.0
    t.decimal  "value_var_24h",           default: 0.0
    t.boolean  "daily_question_answered", default: false
    t.integer  "level",                   default: 1
    t.integer  "xp",                      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "users_average_statistics", force: :cascade do |t|
    t.float    "avg_volume"
    t.float    "avg_transactions"
    t.float    "avg_wallet_views"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

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
