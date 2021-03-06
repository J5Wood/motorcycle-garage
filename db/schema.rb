# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_11_051539) do

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.string "headquarters"
  end

  create_table "motorcycles", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.string "color"
    t.integer "mileage"
    t.string "user_id"
    t.string "brand_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
