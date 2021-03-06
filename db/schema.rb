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

ActiveRecord::Schema.define(version: 20141231062848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "evaluation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["evaluation_id"], name: "index_comments_on_evaluation_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

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

  create_table "naics_codes", force: true do |t|
    t.string   "name"
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
    t.integer  "agency_id"
    t.integer  "solicitation_number_id"
    t.integer  "naics_code_id"
    t.integer  "opportunity_type_id"
  end

  create_table "opportunity_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "search_keywords", force: true do |t|
    t.integer  "team_id"
    t.string   "name"
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

  create_table "solicitation_numbers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.boolean  "private"
  end

  create_table "teams_users", id: false, force: true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  create_table "user_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.integer  "team_id"
    t.integer  "role_id"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",  default: "", null: false
  end

  add_index "users", ["perishable_token"], name: "index_users_on_perishable_token", using: :btree

end
