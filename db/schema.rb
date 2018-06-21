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

ActiveRecord::Schema.define(version: 2018_06_21_072927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gates", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "tag"
    t.text "intro"
    t.string "intro_detail"
    t.boolean "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "server"
    t.integer "like", default: 0
  end

  create_table "like_logs", force: :cascade do |t|
    t.bigint "gate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
    t.string "who_liked"
    t.index ["gate_id"], name: "index_like_logs_on_gate_id"
  end

end
