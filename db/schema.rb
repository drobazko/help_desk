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

ActiveRecord::Schema.define(version: 20140613163819) do

  create_table "departments", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["imageable_id", "imageable_type"], name: "index_pictures_on_imageable_id_and_imageable_type", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.integer  "stuff_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["stuff_id"], name: "index_posts_on_stuff_id", unique: true, using: :btree

  create_table "statuses", force: true do |t|
    t.string   "title"
    t.string   "short_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stuffs", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "member", null: false
    t.integer  "department_id"
  end

  add_index "stuffs", ["department_id"], name: "index_stuffs_on_department_id", unique: true, using: :btree
  add_index "stuffs", ["email"], name: "index_stuffs_on_email", unique: true, using: :btree
  add_index "stuffs", ["reset_password_token"], name: "index_stuffs_on_reset_password_token", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.integer  "status_id"
    t.string   "customer_name",  null: false
    t.string   "customer_email", null: false
    t.string   "token",          null: false
    t.text     "body",           null: false
    t.string   "subject",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stuff_id"
  end

  add_index "tickets", ["status_id"], name: "index_tickets_on_status_id", using: :btree
  add_index "tickets", ["stuff_id"], name: "index_tickets_on_stuff_id", unique: true, using: :btree

end
