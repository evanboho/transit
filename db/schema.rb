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

ActiveRecord::Schema.define(version: 20150208011514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.boolean  "has_direction"
    t.string   "mode"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "next_bus_agencies", force: :cascade do |t|
    t.string   "tag"
    t.string   "title"
    t.string   "short_title"
    t.string   "region_title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "next_bus_agencies", ["tag"], name: "index_next_bus_agencies_on_tag", using: :btree

  create_table "next_bus_routes", force: :cascade do |t|
    t.string   "tag"
    t.string   "title"
    t.string   "lat"
    t.string   "lon"
    t.string   "stop_id"
    t.string   "agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "next_bus_routes", ["agency_id"], name: "index_next_bus_routes_on_agency_id", using: :btree
  add_index "next_bus_routes", ["stop_id"], name: "index_next_bus_routes_on_stop_id", using: :btree
  add_index "next_bus_routes", ["tag"], name: "index_next_bus_routes_on_tag", using: :btree

  create_table "next_bus_stops", force: :cascade do |t|
    t.string   "tag"
    t.string   "title"
    t.string   "lat"
    t.string   "long"
    t.string   "stop_id"
    t.integer  "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "next_bus_stops", ["route_id"], name: "index_next_bus_stops_on_route_id", using: :btree
  add_index "next_bus_stops", ["stop_id"], name: "index_next_bus_stops_on_stop_id", using: :btree
  add_index "next_bus_stops", ["tag"], name: "index_next_bus_stops_on_tag", using: :btree

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
