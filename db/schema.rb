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

ActiveRecord::Schema.define(version: 20140928011922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "contact_person"
    t.string   "address"
    t.string   "contact_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "invoice_items", force: true do |t|
    t.integer  "invoice_id"
    t.string   "name"
    t.decimal  "unit_amount"
    t.decimal  "quantity",    precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree

  create_table "invoices", force: true do |t|
    t.string   "number"
    t.date     "date"
    t.string   "client_reference_number"
    t.integer  "project_id"
    t.date     "due_date"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "html"
    t.text     "payment_details"
    t.string   "currency"
    t.string   "page_size"
    t.boolean  "no_quantity",             default: false
  end

  add_index "invoices", ["project_id"], name: "index_invoices_on_project_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "user_details", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "country"
    t.string   "postal_code"
    t.string   "contact_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_details", ["user_id"], name: "index_user_details_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", using: :btree

end
