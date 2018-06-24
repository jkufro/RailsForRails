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

ActiveRecord::Schema.define(version: 20180624165003) do

  create_table "park_passes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "pass_type_id"
    t.string "first_name"
    t.string "last_name"
    t.string "card_number"
    t.date "card_expiration"
    t.integer "height", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pass_types", force: :cascade do |t|
    t.string "pass_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quueues", force: :cascade do |t|
    t.integer "ride_id"
    t.integer "visit_id"
    t.string "queue_code"
    t.boolean "checked_in", default: false
    t.string "security_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.integer "carts_on_track"
    t.integer "ride_duration"
    t.text "ride_description"
    t.integer "cart_occupancy"
    t.string "max_allowed_queue_code", default: 'AAAAA'
    t.boolean "allow_queue", default: true
    t.boolean "active", default: true
    t.integer "min_height", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ride_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "phone"
    t.string "role", default: 'visitor'
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visits", force: :cascade do |t|
    t.date "visit_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "park_pass_id"
  end

end
