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

ActiveRecord::Schema.define(version: 20161117075513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "briefing_sessions", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "location",    limit: 12, null: false
    t.date     "bs_date",                null: false
    t.time     "start_time",             null: false
    t.time     "finish_time",            null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "com_name",         limit: 100, null: false
    t.string   "head_office",      limit: 30,  null: false
    t.integer  "employees_number",             null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "sub_industry_id"
    t.string   "sub_str",          limit: 100
  end

  add_index "companies", ["sub_industry_id"], name: "index_companies_on_sub_industry_id", using: :btree

  create_table "main_industries", force: :cascade do |t|
    t.string   "main_t",     limit: 20, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string   "site_name",  limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "sub_industries", force: :cascade do |t|
    t.integer  "main_industry_id"
    t.string   "sub_t",            limit: 100, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "urls", force: :cascade do |t|
    t.integer  "briefing_session_id"
    t.string   "url_val",             limit: 500, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "site_id"
  end

  add_index "urls", ["site_id"], name: "index_urls_on_site_id", using: :btree

  add_foreign_key "briefing_sessions", "companies"
  add_foreign_key "companies", "sub_industries"
  add_foreign_key "sub_industries", "main_industries"
  add_foreign_key "urls", "briefing_sessions"
  add_foreign_key "urls", "sites"
end
