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

ActiveRecord::Schema.define(version: 20150728033636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.integer  "tournament_id"
    t.string   "winner"
    t.string   "loser"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "player_one"
    t.integer  "player_two"
  end

  add_index "matches", ["tournament_id"], name: "index_matches_on_tournament_id", using: :btree

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
  end

  add_index "players", ["username"], name: "index_players_on_username", using: :btree

  create_table "statistics", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "macro"
    t.integer  "micro"
    t.integer  "vt"
    t.integer  "vz"
    t.integer  "vp"
    t.integer  "talent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "statistics", ["player_id"], name: "index_statistics_on_player_id", using: :btree

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
    t.integer  "players",    default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "tournaments", ["name"], name: "index_tournaments_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "deleted",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
