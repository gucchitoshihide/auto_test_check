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

ActiveRecord::Schema.define(version: 7) do

  create_table "article_comments", force: true do |t|
    t.integer  "article_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_comments", ["comment_id"], name: "index_article_comments_on_comment_id"

  create_table "article_week_reports", force: true do |t|
    t.integer  "article_id"
    t.integer  "week_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_week_reports", ["article_id"], name: "index_article_week_reports_on_article_id"
  add_index "article_week_reports", ["week_report_id"], name: "index_article_week_reports_on_week_report_id"

  create_table "articles", force: true do |t|
    t.integer  "week_report_id"
    t.integer  "skill_profile_id"
    t.string   "title",            null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content",    null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "skill_profiles", force: true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_profiles", ["article_id"], name: "index_skill_profiles_on_article_id"
  add_index "skill_profiles", ["user_id"], name: "index_skill_profiles_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "week_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "week_reports", ["article_id"], name: "index_week_reports_on_article_id"
  add_index "week_reports", ["user_id"], name: "index_week_reports_on_user_id"

end
