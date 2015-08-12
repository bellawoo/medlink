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

ActiveRecord::Schema.define(version: 20150812183649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string  "name",              limit: 255
    t.integer "twilio_account_id"
  end

  create_table "country_supplies", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "supply_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "country_supplies", ["country_id"], name: "index_country_supplies_on_country_id", using: :btree
  add_index "country_supplies", ["supply_id"], name: "index_country_supplies_on_supply_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at"
    t.string   "number",            limit: 255
    t.string   "text",              limit: 255
    t.integer  "direction"
    t.integer  "user_id"
    t.integer  "twilio_account_id"
  end

  add_index "messages", ["twilio_account_id"], name: "index_messages_on_twilio_account_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "country_id"
    t.integer  "user_id"
    t.integer  "request_id"
    t.integer  "supply_id"
    t.integer  "response_id"
    t.string   "delivery_method", limit: 255
    t.datetime "duplicated_at"
  end

  create_table "phones", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "user_id"
    t.string   "number",     limit: 255
    t.string   "condensed",  limit: 255
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "country_id"
    t.integer  "user_id"
    t.integer  "message_id"
    t.text     "text"
    t.integer  "entered_by"
  end

  create_table "responses", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "country_id"
    t.integer  "user_id"
    t.integer  "message_id"
    t.string   "extra_text",  limit: 255
    t.datetime "archived_at"
  end

  create_table "supplies", force: :cascade do |t|
    t.string "shortcode", limit: 255
    t.string "name",      limit: 255
  end

  add_index "supplies", ["shortcode"], name: "index_supplies_on_shortcode", using: :btree

  create_table "twilio_accounts", force: :cascade do |t|
    t.string   "sid",        limit: 255
    t.string   "auth",       limit: 255
    t.string   "number",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "pcv_id",                 limit: 255
    t.integer  "country_id"
    t.integer  "role"
    t.string   "location",               limit: 255
    t.string   "time_zone",              limit: 255
    t.datetime "waiting_since"
    t.datetime "last_requested_at"
    t.datetime "welcome_video_shown_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "country_supplies", "countries"
  add_foreign_key "country_supplies", "supplies"
  add_foreign_key "messages", "twilio_accounts"
  add_foreign_key "messages", "users"
  add_foreign_key "orders", "requests"
  add_foreign_key "orders", "supplies"
  add_foreign_key "phones", "users"
  add_foreign_key "requests", "countries"
  add_foreign_key "requests", "messages"
  add_foreign_key "requests", "users"
  add_foreign_key "responses", "countries"
  add_foreign_key "responses", "messages"
  add_foreign_key "responses", "users"
end
