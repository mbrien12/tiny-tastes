# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_02_27_204910) do
  create_table "onboardings", force: :cascade do |t|
    t.string "token"
    t.integer "user_id", null: false
    t.string "current_step"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_onboardings_on_token"
    t.index ["user_id"], name: "index_onboardings_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "meals_per_week"
    t.integer "price_pence"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "postcode"
    t.integer "plan_id"
    t.integer "baby_age_years"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["plan_id"], name: "index_users_on_plan_id"
  end

  add_foreign_key "onboardings", "users"
  add_foreign_key "users", "plans"
end
