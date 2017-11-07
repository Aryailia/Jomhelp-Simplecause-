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

ActiveRecord::Schema.define(version: 20171107040825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributors", force: :cascade do |t|
    t.integer "charity_id", null: false
    t.integer "user_id", null: false
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", id: :serial, force: :cascade do |t|
    t.integer "organisation_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organisation_id", "user_id"], name: "index_follows_on_organisation_id_and_user_id", unique: true
    t.index ["organisation_id"], name: "index_follows_on_organisation_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "postcode", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "follows", "organisations"
  add_foreign_key "follows", "users"
end
