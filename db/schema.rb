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

ActiveRecord::Schema.define(version: 20160305173049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "provider",   limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["uid", "provider"], name: "index_authentications_on_uid_and_provider", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "contact_person", limit: 255
    t.string   "address",        limit: 255
    t.string   "contact_number", limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "invoice_id"
    t.string   "name",        limit: 255
    t.decimal  "unit_amount"
    t.decimal  "quantity",                precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "number",                  limit: 255
    t.date     "date"
    t.string   "client_reference_number", limit: 255
    t.integer  "project_id"
    t.date     "due_date"
    t.integer  "user_id"
    t.string   "status",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "html"
    t.text     "payment_details"
    t.string   "currency",                limit: 255
    t.string   "page_size",               limit: 255
    t.boolean  "no_quantity",                                                  default: false
    t.integer  "payment_detail_id"
    t.decimal  "total_amount",                        precision: 15, scale: 2
  end

  add_index "invoices", ["payment_detail_id"], name: "index_invoices_on_payment_detail_id", using: :btree
  add_index "invoices", ["project_id"], name: "index_invoices_on_project_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "payment_details", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_details", ["user_id"], name: "index_payment_details_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "user_details", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",           limit: 255
    t.string   "address1",       limit: 255
    t.string   "address2",       limit: 255
    t.string   "address3",       limit: 255
    t.string   "country",        limit: 255
    t.string   "postal_code",    limit: 255
    t.string   "contact_number", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_details", ["user_id"], name: "index_user_details_on_user_id", using: :btree

  create_table "user_options", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.string   "datatype",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_options", ["user_id"], name: "index_user_options_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token",      limit: 255
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", using: :btree

end
