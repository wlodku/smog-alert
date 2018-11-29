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

ActiveRecord::Schema.define(version: 20181114095412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "averages", force: :cascade do |t|
    t.float    "pm10"
    t.float    "pm25"
    t.date     "day"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_averages_on_station_id", using: :btree
  end

  create_table "installations", force: :cascade do |t|
    t.string   "name"
    t.integer  "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measurements", force: :cascade do |t|
    t.integer  "pm1"
    t.integer  "pm25"
    t.integer  "pm10"
    t.integer  "station_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "epoch"
    t.datetime "measured_at"
    t.integer  "qi"
    t.integer  "installation_id"
    t.index ["installation_id"], name: "index_measurements_on_installation_id", using: :btree
    t.index ["station_id"], name: "index_measurements_on_station_id", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sensor_id"
  end

  create_table "stats", force: :cascade do |t|
    t.float    "pm10"
    t.float    "pm25"
    t.date     "day"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_stats_on_station_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "installation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["installation_id"], name: "index_subscriptions_on_installation_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_active",              default: true
    t.integer  "critical",               default: 2
    t.datetime "email_sent_at"
    t.boolean  "is_admin",               default: false
    t.integer  "delay",                  default: 8
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "averages", "stations"
  add_foreign_key "measurements", "stations"
  add_foreign_key "stats", "stations"
end
