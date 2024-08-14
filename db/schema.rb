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

ActiveRecord::Schema[7.1].define(version: 2024_08_14_102540) do
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
    t.integer "installment_type", default: 0
    t.bigint "user_id"
    t.string "txn_number"
    t.index ["invoice_number"], name: "index_installments_on_invoice_number", unique: true
    t.index ["student_id", "number", "installment_type"], name: "idx_on_student_id_number_installment_type_9e04eac66b"
    t.index ["student_id"], name: "index_installments_on_student_id"
    t.index ["user_id"], name: "index_installments_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "group"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name", unique: true
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
    t.integer "category", default: 0
    t.float "exam_fee"
    t.boolean "opted_for_certificate", default: false
    t.string "institution"
    t.string "referred_by"
    t.date "course_completed_at"
    t.bigint "user_id"
    t.integer "institution_type", default: 0
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "user_permissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "permission_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_user_permissions_on_permission_id"
    t.index ["user_id", "permission_id"], name: "index_user_permissions_on_user_id_and_permission_id", unique: true
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "installments", "students"
  add_foreign_key "installments", "users"
  add_foreign_key "student_courses", "courses"
  add_foreign_key "student_courses", "students"
  add_foreign_key "students", "users"
  add_foreign_key "user_permissions", "permissions"
  add_foreign_key "user_permissions", "users"
end
