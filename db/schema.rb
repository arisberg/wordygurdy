# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150424234324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "puzzles", force: :cascade do |t|
    t.string   "clue"
    t.string   "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "solved"
    t.integer  "user_id"
    t.integer  "score"
  end

  add_index "puzzles", ["user_id"], name: "index_puzzles_on_user_id", using: :btree

  create_table "solved_puzzles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "puzzle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "solved_puzzles", ["puzzle_id"], name: "index_solved_puzzles_on_puzzle_id", using: :btree
  add_index "solved_puzzles", ["user_id"], name: "index_solved_puzzles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "score"
    t.string   "rankimage"
  end

  add_foreign_key "puzzles", "users"
  add_foreign_key "solved_puzzles", "puzzles"
  add_foreign_key "solved_puzzles", "users"
end
