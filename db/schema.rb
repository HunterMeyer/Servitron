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

ActiveRecord::Schema.define(version: 20170125165254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.integer  "delayed_reference_id"
    t.text     "delayed_reference_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["delayed_reference_id"], name: "delayed_jobs_delayed_reference_id", using: :btree
  add_index "delayed_jobs", ["delayed_reference_type"], name: "delayed_jobs_delayed_reference_type", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue"], name: "delayed_jobs_queue", using: :btree

  create_table "screenshots", force: :cascade do |t|
    t.text     "website"
    t.text     "file_url"
    t.text     "callback_url"
    t.text     "status",       default: "Active"
    t.json     "options",      default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "screenshots", ["status"], name: "screenshots_status", using: :btree
  add_index "screenshots", ["website"], name: "screenshots_website", using: :btree

  create_table "users", force: :cascade do |t|
    t.text    "first_name"
    t.text    "last_name"
    t.text    "email"
    t.text    "api_key"
    t.text    "status",      default: "Active"
    t.boolean "api_enabled", default: false
  end

  add_index "users", ["api_key"], name: "index_users_on_api_key", using: :btree
  add_index "users", ["status"], name: "index_users_on_status", using: :btree

end
