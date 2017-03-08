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

ActiveRecord::Schema.define(version: 20170306122433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.integer  "country_id"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
  end

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
    t.integer  "width"
    t.integer  "depth"
    t.integer  "publication"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "materials"
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

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "discount"
    t.string   "code"
    t.integer  "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_coupons_on_cart_id", using: :btree
    t.index ["code"], name: "index_coupons_on_code", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "number"
    t.string   "name"
    t.string   "cvv"
    t.integer  "expiry_month"
    t.integer  "expiry_year"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["order_id"], name: "index_credit_cards_on_order_id", using: :btree
    t.index ["user_id"], name: "index_credit_cards_on_user_id", using: :btree
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 10, scale: 2
    t.integer  "min_days"
    t.integer  "max_days"
    t.integer  "country_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["country_id"], name: "index_deliveries_on_country_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "cart_id"
    t.integer  "quantity",                           default: 1
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "order_id"
    t.index ["book_id"], name: "index_line_items_on_book_id", using: :btree
    t.index ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
    t.index ["order_id"], name: "index_line_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "state"
    t.integer  "user_id"
    t.decimal  "total_price",    precision: 10, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "delivery_id"
    t.integer  "credit_card_id"
    t.index ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
    t.index ["delivery_id"], name: "index_orders_on_delivery_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
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
    t.string   "title"
    t.integer  "rate"
    t.text     "description"
    t.integer  "book_id"
    t.boolean  "verified",    default: false
    t.string   "state"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id"
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "countries"
  add_foreign_key "coupons", "carts"
  add_foreign_key "credit_cards", "orders"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "deliveries", "countries"
  add_foreign_key "line_items", "books"
  add_foreign_key "line_items", "carts"
  add_foreign_key "orders", "credit_cards"
  add_foreign_key "orders", "deliveries"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
