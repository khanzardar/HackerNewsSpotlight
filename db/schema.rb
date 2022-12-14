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

ActiveRecord::Schema.define(version: 2022_10_16_015102) do

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.integer "story_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.string "by"
    t.string "time"
    t.index ["story_id"], name: "index_comments_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "by"
    t.integer "total_comment_count"
    t.string "hn_story_id"
    t.integer "score"
    t.string "time"
    t.text "title"
    t.text "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "comments", "stories"
end
