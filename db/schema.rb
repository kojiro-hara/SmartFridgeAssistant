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

ActiveRecord::Schema[7.1].define(version: 2025_05_22_053745) do
  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.date "expiry_date"
    t.string "category"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit"
    t.integer "stock_quantity", default: 0
  end

  create_table "menu_ingredients", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "school_lunch_id", null: false
    t.bigint "food_id", null: false
    t.integer "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_menu_ingredients_on_food_id"
    t.index ["school_lunch_id"], name: "index_menu_ingredients_on_school_lunch_id"
  end

  create_table "purchase_histories", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "food_id", null: false
    t.date "purchase_date", null: false
    t.integer "quantity", null: false
    t.string "unit", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_purchase_histories_on_food_id"
    t.index ["purchase_date"], name: "index_purchase_histories_on_purchase_date"
  end

  create_table "school_events", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "event_type"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_lunches", charset: "utf8mb4", force: :cascade do |t|
    t.date "date"
    t.string "main_dish"
    t.string "side_dish"
    t.string "soup"
    t.string "dessert"
    t.integer "calories"
    t.text "nutrition_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "menu_ingredients", "foods"
  add_foreign_key "menu_ingredients", "school_lunches"
  add_foreign_key "purchase_histories", "foods"
end
