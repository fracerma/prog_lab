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

ActiveRecord::Schema.define(version: 2020_05_15_175317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fav_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_fav_categories_on_category_id"
    t.index ["user_id"], name: "index_fav_categories_on_user_id"
  end

  create_table "fav_locations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_fav_locations_on_location_id"
    t.index ["user_id"], name: "index_fav_locations_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "gatherings", force: :cascade do |t|
    t.datetime "date"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_gatherings_on_location_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "gathering_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gathering_id"], name: "index_groups_on_gathering_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.float "long"
    t.float "lat"
    t.string "foto"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "vote"
    t.text "comment"
    t.date "date"
    t.bigint "users_id"
    t.bigint "locations_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locations_id"], name: "index_reviews_on_locations_id"
    t.index ["users_id"], name: "index_reviews_on_users_id"
  end

  create_table "types", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "location_id"
    t.index ["category_id"], name: "index_types_on_category_id"
    t.index ["location_id"], name: "index_types_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "avatar"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "friendships", "users"
end
