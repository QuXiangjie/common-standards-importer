# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2015_07_08_101057) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "jurisdictions", force: :cascade do |t|
    t.string "csp_id"
    t.json "document"
    t.string "title"
    t.string "type"
    t.index ["csp_id"], name: "index_jurisdictions_on_csp_id"
  end

  create_table "standards", force: :cascade do |t|
    t.integer "child_count", default: 0
    t.string "csp_id"
    t.json "document"
    t.string "education_levels", default: [], null: false, array: true
    t.boolean "indexed", default: false, null: false
    t.integer "jurisdiction_id", null: false
    t.integer "parent_ids", default: [], null: false, array: true
    t.string "subject"
    t.string "title"
    t.index ["csp_id"], name: "index_standards_on_csp_id"
    t.index ["jurisdiction_id"], name: "index_standards_on_jurisdiction_id"
    t.index ["parent_ids"], name: "index_standards_on_parent_ids", using: :gin
  end

  create_table "standards_schema_migrations", id: false, force: :cascade do |t|
    t.string "version", null: false
    t.index ["version"], name: "unique_schema_migrations", unique: true
  end

  add_foreign_key "standards", "jurisdictions"
end
