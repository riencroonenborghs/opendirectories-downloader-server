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

ActiveRecord::Schema.define(version: 2019_08_03_035364) do

  create_table "downloads", force: :cascade do |t|
    t.integer "user_id"
    t.string "url", null: false
    t.string "status", default: "initial", null: false
    t.string "http_username"
    t.string "http_password"
    t.datetime "queued_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "cancelled_at"
    t.string "file_filter"
    t.integer "weight", default: 9999, null: false
    t.text "job_id"
    t.boolean "audio_only", default: false, null: false
    t.string "audio_format", default: "mp3", null: false
    t.boolean "download_subs", default: false, null: false
    t.boolean "srt_subs", default: false, null: false
    t.index ["user_id"], name: "index_downloads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
