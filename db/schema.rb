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

ActiveRecord::Schema[7.0].define(version: 2023_09_25_021734) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stress_relief_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stress_relief_id"], name: "index_likes_on_stress_relief_id"
    t.index ["user_id", "stress_relief_id"], name: "index_likes_on_user_id_and_stress_relief_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "stress_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "stress_relief_date", null: false
    t.string "title"
    t.text "detail"
    t.integer "before_stress_level"
    t.integer "after_stress_level"
    t.text "impression"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stress_records_on_user_id"
  end

  create_table "stress_relief_tags", force: :cascade do |t|
    t.bigint "stress_relief_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stress_relief_id", "tag_id"], name: "index_stress_relief_tags_on_stress_relief_id_and_tag_id", unique: true
    t.index ["stress_relief_id"], name: "index_stress_relief_tags_on_stress_relief_id"
    t.index ["tag_id"], name: "index_stress_relief_tags_on_tag_id"
  end

  create_table "stress_reliefs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "detail", null: false
    t.integer "difficulty", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stress_reliefs_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "likes", "stress_reliefs"
  add_foreign_key "likes", "users"
  add_foreign_key "stress_records", "users"
  add_foreign_key "stress_relief_tags", "stress_reliefs"
  add_foreign_key "stress_relief_tags", "tags"
  add_foreign_key "stress_reliefs", "users"
end
