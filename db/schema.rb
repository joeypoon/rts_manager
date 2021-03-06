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

ActiveRecord::Schema.define(version: 20150804211610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.integer  "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "player_one"
    t.integer  "player_two"
    t.integer  "winner"
    t.integer  "loser"
  end

  add_index "matches", ["round_id"], name: "index_matches_on_round_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "username"
    t.integer  "age"
    t.integer  "salary"
    t.string   "race"
    t.integer  "earnings",   default: 0
    t.integer  "wins",       default: 0
    t.integer  "losses",     default: 0
    t.boolean  "retired",    default: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "macro"
    t.decimal  "micro"
    t.decimal  "vt"
    t.decimal  "vz"
    t.decimal  "vp"
    t.decimal  "talent"
  end

  add_index "players", ["username"], name: "index_players_on_username", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "players",       default: [],              array: true
    t.integer  "winners",       default: [],              array: true
    t.integer  "round_number"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "walk_overs",    default: [],              array: true
  end

  add_index "rounds", ["tournament_id"], name: "index_rounds_on_tournament_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "cash",       default: 10000
    t.integer  "user_id"
    t.boolean  "bankrupt",   default: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "wins",       default: 0
    t.integer  "losses",     default: 0
  end

  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.integer  "prize_pool"
    t.string   "winner"
    t.integer  "players",     default: [],                 array: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "played",      default: false
    t.integer  "max_players", default: 32
  end

  add_index "tournaments", ["name"], name: "index_tournaments_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "deleted",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "token"
  end

end
