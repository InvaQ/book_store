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

ActiveRecord::Schema.define(version: 20170121132906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "book_id",   null: false
    t.index ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "depth"
    t.integer  "publication"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id", "category_id"], name: "index_categorizations_on_book_id_and_category_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "cart_id"
    t.integer  "quantity",                           default: 1
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["book_id"], name: "index_line_items_on_book_id", using: :btree
    t.index ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image_url"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_url",  default: "https://goo.gl/Q5p7FL"
    t.integer  "rate"
    t.text     "description"
    t.boolean  "verified"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_foreign_key "line_items", "books"
  add_foreign_key "line_items", "carts"
end
