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

ActiveRecord::Schema.define(version: 2) do

  create_table "reports", force: true do |t|
    t.integer  "week_report_id"
    t.string   "title",          null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "week_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "week_reports", ["report_id"], name: "index_week_reports_on_report_id"
  add_index "week_reports", ["user_id"], name: "index_week_reports_on_user_id"

end
