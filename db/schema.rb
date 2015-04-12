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

ActiveRecord::Schema.define(version: 20150412043317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "absences", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "at",         null: false
    t.string   "shift",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "absences", ["user_id"], name: "index_absences_on_user_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "user_id",                                                                  null: false
    t.uuid     "public_id",                                 default: "uuid_generate_v4()"
    t.string   "name",                                                                     null: false
    t.decimal  "price",            precision: 10, scale: 2,                                null: false
    t.decimal  "price_per_person", precision: 10, scale: 2,                                null: false
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.string   "tags",                                      default: [],                                array: true
    t.integer  "number_of_people",                          default: [],                   null: false, array: true
  end

  add_index "menus", ["user_id"], name: "index_menus_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                                           null: false
    t.string   "email",                                          null: false
    t.string   "password_digest",                                null: false
    t.text     "bio"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.uuid     "public_id",       default: "uuid_generate_v4()"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
