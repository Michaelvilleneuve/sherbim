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

ActiveRecord::Schema.define(version: 20160204075112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "mark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participants", ["service_id"], name: "index_participants_on_service_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "place"
    t.string   "transport"
    t.boolean  "statut"
    t.float    "price"
    t.datetime "date"
    t.string   "code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "nbpart"
    t.string   "longitude"
    t.string   "latitude"
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "debit"
    t.integer  "receive"
    t.float    "amount"
    t.integer  "service_id"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["service_id"], name: "index_transactions_on_service_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "firstname"
    t.text     "description"
    t.string   "email"
    t.string   "phone"
    t.integer  "age"
    t.float    "points"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image"
    t.string   "role"
  end

  add_foreign_key "comments", "users"
  add_foreign_key "participants", "services"
  add_foreign_key "participants", "users"
  add_foreign_key "services", "users"
  add_foreign_key "transactions", "services"
end
