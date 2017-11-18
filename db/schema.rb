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

ActiveRecord::Schema.define(version: 20171118033129) do

  create_table "downloads", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url",                               null: false
    t.string   "status",        default: "initial", null: false
    t.string   "http_username"
    t.string   "http_password"
    t.datetime "queued_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text     "error"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.datetime "cancelled_at"
    t.string   "file_filter"
    t.integer  "weight",        default: 9999,      null: false
    t.text     "job_id"
    t.boolean  "audio_only",    default: false,     null: false
    t.string   "audio_format",  default: "mp3",     null: false
    t.boolean  "download_subs", default: false,     null: false
    t.boolean  "srt_subs",      default: false,     null: false
  end

  add_index "downloads", ["user_id"], name: "index_downloads_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider",                         null: false
    t.string   "uid",                 default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true

end
