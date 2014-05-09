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

ActiveRecord::Schema.define(version: 20140506123928) do

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.string   "name"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["opportunity_id"], name: "index_comments_on_opportunity_id"

  create_table "opportunities", force: true do |t|
    t.text     "opportunity"
    t.text     "opportunity_description"
    t.string   "agency"
    t.string   "opp_type"
    t.date     "post_date"
    t.date     "response_date"
    t.string   "link"
    t.text     "comments"
    t.string   "management_evaluation"
    t.integer  "like",                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "class_code"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

end
