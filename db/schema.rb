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

ActiveRecord::Schema.define(version: 2019_07_16_212256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "pet_products", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "product_id"
    t.text "notes"
    t.boolean "good_or_bad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_products_on_pet_id"
    t.index ["product_id"], name: "index_pet_products_on_product_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "archetype"
    t.string "breed"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "avg_price"
    t.float "avg_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_products", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_user_products_on_product_id"
    t.index ["user_id"], name: "index_user_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
