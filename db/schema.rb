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

ActiveRecord::Schema.define(version: 20140816181620) do

  create_table "classification_codes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classification_codes_selection_criteria", id: false, force: true do |t|
    t.integer "classification_code_id"
    t.integer "selection_criterium_id"
  end

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.string   "name"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["opportunity_id"], name: "index_comments_on_opportunity_id"

  create_table "evaluation_codes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "evaluation_code_id"
    t.integer  "opportunity_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "procurement_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procurement_types_selection_criteria", id: false, force: true do |t|
    t.integer "procurement_type_id"
    t.integer "selection_criterium_id"
  end

  create_table "roles", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selection_criteria", force: true do |t|
    t.integer  "team_id"
    t.integer  "set_aside_radio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selection_criteria_set_asides", id: false, force: true do |t|
    t.integer "set_aside_id"
    t.integer "selection_criterium_id"
  end

  create_table "set_aside_radios", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "set_asides", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "description"
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
    t.integer  "team_id"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
