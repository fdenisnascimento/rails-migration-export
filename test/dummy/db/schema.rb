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

ActiveRecord::Schema.define(version: 20170113175858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "brand"
    t.string   "mask"
    t.integer  "payment_transaction_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cards", ["payment_transaction_id"], name: "index_cards_on_payment_transaction_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "sku"
    t.string   "name"
    t.string   "description"
    t.integer  "unit_price"
    t.integer  "quantity",        default: 1
    t.string   "unit_of_measure"
    t.string   "details"
    t.string   "reference"
    t.string   "uuid"
    t.integer  "order_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "sku_type"
  end

  add_index "items", ["order_id"], name: "index_items_on_order_id", using: :btree
  add_index "items", ["sku"], name: "index_items_on_sku", using: :btree
  add_index "items", ["uuid"], name: "index_items_on_uuid", unique: true, using: :btree

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.string   "email"
    t.string   "uuid",             limit: 40
    t.string   "notification_url"
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "merchants", ["deleted_at"], name: "index_merchants_on_deleted_at", using: :btree
  add_index "merchants", ["number"], name: "index_merchants_on_number", using: :btree
  add_index "merchants", ["uuid"], name: "index_merchants_on_uuid", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "external_id"
    t.string   "number"
    t.string   "reference"
    t.integer  "status"
    t.string   "notes"
    t.integer  "price"
    t.integer  "remaining",              default: 0
    t.integer  "paid_amount",            default: 0
    t.string   "merchant_id", limit: 40
    t.string   "uuid",        limit: 40
    t.datetime "deleted_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "terminal_id"
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  add_index "orders", ["external_id"], name: "index_orders_on_external_id", using: :btree
  add_index "orders", ["number"], name: "index_orders_on_number", using: :btree
  add_index "orders", ["reference"], name: "index_orders_on_reference", using: :btree
  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree
  add_index "orders", ["terminal_id"], name: "index_orders_on_terminal_id", using: :btree
  add_index "orders", ["uuid"], name: "index_orders_on_uuid", unique: true, using: :btree

  create_table "payment_products", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.integer  "payment_transaction_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "payment_products", ["name"], name: "index_payment_products_on_name", using: :btree
  add_index "payment_products", ["number"], name: "index_payment_products_on_number", using: :btree
  add_index "payment_products", ["payment_transaction_id"], name: "index_payment_products_on_payment_transaction_id", using: :btree

  create_table "payment_services", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.integer  "payment_product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "payment_services", ["name"], name: "index_payment_services_on_name", using: :btree
  add_index "payment_services", ["number"], name: "index_payment_services_on_number", using: :btree
  add_index "payment_services", ["payment_product_id"], name: "index_payment_services_on_payment_product_id", using: :btree

  create_table "payment_transactions", force: :cascade do |t|
    t.string   "uuid"
    t.string   "external_id"
    t.string   "transaction_type"
    t.string   "status"
    t.string   "description"
    t.string   "terminal_number"
    t.string   "number"
    t.string   "authorization_code"
    t.integer  "amount"
    t.integer  "order_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "payment_transactions", ["authorization_code"], name: "index_payment_transactions_on_authorization_code", using: :btree
  add_index "payment_transactions", ["number"], name: "index_payment_transactions_on_number", using: :btree
  add_index "payment_transactions", ["order_id"], name: "index_payment_transactions_on_order_id", using: :btree
  add_index "payment_transactions", ["terminal_number"], name: "index_payment_transactions_on_terminal_number", using: :btree
  add_index "payment_transactions", ["uuid"], name: "index_payment_transactions_on_uuid", unique: true, using: :btree

  create_table "terminals", force: :cascade do |t|
    t.string   "number"
    t.string   "uuid",        limit: 40
    t.integer  "merchant_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "terminals", ["merchant_id"], name: "index_terminals_on_merchant_id", using: :btree
  add_index "terminals", ["number"], name: "index_terminals_on_number", using: :btree
  add_index "terminals", ["uuid"], name: "index_terminals_on_uuid", unique: true, using: :btree

  add_foreign_key "cards", "payment_transactions"
  add_foreign_key "items", "orders"
  add_foreign_key "orders", "terminals"
  add_foreign_key "payment_products", "payment_transactions"
  add_foreign_key "payment_services", "payment_products"
  add_foreign_key "payment_transactions", "orders"
  add_foreign_key "terminals", "merchants"
end
