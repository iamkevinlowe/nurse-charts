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

ActiveRecord::Schema.define(version: 20151208173957) do

  create_table "blood_pressures", force: :cascade do |t|
    t.integer  "vital_id"
    t.float    "systolic"
    t.float    "diastolic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "blood_pressures", ["vital_id"], name: "index_blood_pressures_on_vital_id"

  create_table "careplans", force: :cascade do |t|
    t.integer  "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "careplans", ["patient_id"], name: "index_careplans_on_patient_id"

  create_table "goals", force: :cascade do |t|
    t.string   "activity"
    t.integer  "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "goals", ["issue_id"], name: "index_goals_on_issue_id"

  create_table "hospitals", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "name"
    t.integer  "careplan_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "issues", ["careplan_id"], name: "index_issues_on_careplan_id"

  create_table "patients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "room_number"
    t.integer  "hospital_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "patients", ["hospital_id"], name: "index_patients_on_hospital_id"

  create_table "pulse_rates", force: :cascade do |t|
    t.integer  "vital_id"
    t.integer  "bpm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pulse_rates", ["vital_id"], name: "index_pulse_rates_on_vital_id"

  create_table "reports", force: :cascade do |t|
    t.integer  "activity_id"
    t.string   "activity_type"
    t.integer  "patient_id"
    t.integer  "user_id"
    t.integer  "alert"
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "reports", ["activity_type", "activity_id"], name: "index_reports_on_activity_type_and_activity_id"
  add_index "reports", ["patient_id"], name: "index_reports_on_patient_id"
  add_index "reports", ["user_id"], name: "index_reports_on_user_id"

  create_table "respiration_rates", force: :cascade do |t|
    t.integer  "vital_id"
    t.integer  "bpm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "respiration_rates", ["vital_id"], name: "index_respiration_rates_on_vital_id"

  create_table "temperatures", force: :cascade do |t|
    t.integer  "vital_id"
    t.float    "celsius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "temperatures", ["vital_id"], name: "index_temperatures_on_vital_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                                null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "hospital_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["hospital_id"], name: "index_users_on_hospital_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vitals", force: :cascade do |t|
    t.integer  "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vitals", ["patient_id"], name: "index_vitals_on_patient_id"

end
