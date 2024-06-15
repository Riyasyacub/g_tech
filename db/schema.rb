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

ActiveRecord::Schema[7.1].define(version: 2024_06_15_191638) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.float "total_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "student_id", null: false
    t.date "date"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.string "invoice_number"
    t.integer "mode_of_payment", default: 0
    t.index ["invoice_number"], name: "index_installments_on_invoice_number", unique: true
    t.index ["student_id", "number"], name: "index_installments_on_student_id_and_number", unique: true
    t.index ["student_id"], name: "index_installments_on_student_id"
  end

  create_table "student_courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "student_id", null: false
    t.uuid "course_id", null: false
    t.string "name"
    t.float "amount"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_courses_on_course_id"
    t.index ["student_id"], name: "index_student_courses_on_student_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "roll_no"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_fees"
    t.string "contact_number"
    t.text "courses"
    t.date "date_of_joining"
  end

  add_foreign_key "installments", "students"
  add_foreign_key "student_courses", "courses"
  add_foreign_key "student_courses", "students"
end
