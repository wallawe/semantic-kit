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

ActiveRecord::Schema.define(version: 20141211161430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", force: true do |t|
    t.integer  "theme_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscription_id"
  end

  create_table "expos", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.boolean  "approved",   default: false
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "favorited_id"
    t.string   "favorited_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["favorited_id", "favorited_type"], name: "index_favorites_on_favorited_id_and_favorited_type", using: :btree

  create_table "guest_subscriptions", force: true do |t|
    t.integer  "theme_id"
    t.string   "token"
    t.string   "email"
    t.decimal  "price_tier", precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: true do |t|
    t.integer  "user_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_lists", force: true do |t|
    t.integer  "theme_id"
    t.decimal  "single_tier",   precision: 5, scale: 2
    t.decimal  "multiple_tier", precision: 5, scale: 2
    t.decimal  "extended_tier", precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales_trackers", force: true do |t|
    t.integer  "theme_id"
    t.integer  "sale_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "single_tier_count",   default: 0
    t.integer  "multiple_tier_count", default: 0
    t.integer  "extended_tier_count", default: 0
  end

  create_table "snippets", force: true do |t|
    t.string   "title"
    t.text     "html"
    t.text     "css"
    t.text     "js"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image"
  end

  create_table "stripe_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "recipient_id"
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price_tier", precision: 5, scale: 2
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["theme_id"], name: "index_taggings_on_theme_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theme_categories", force: true do |t|
    t.integer  "category_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "preview_url"
    t.string   "file_package"
    t.boolean  "approved",     default: false
    t.string   "preprocessor"
    t.string   "browsers",     default: [],    array: true
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "location"
    t.string   "website"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end
