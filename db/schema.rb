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

ActiveRecord::Schema.define(version: 20170314171937) do

  create_table "accepted_tutor_requests", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "tutor_subject_id",           null: false
    t.bigint   "student_id"
    t.bigint   "tutor_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "tutor_rating",     limit: 1
    t.integer  "student_rating",   limit: 1
    t.index ["student_id", "created_at"], name: "idx_accepted_student_created", using: :btree
    t.index ["tutor_id", "created_at"], name: "idx_accepted_tutor_created", using: :btree
    t.index ["tutor_subject_id"], name: "index_accepted_tutor_requests_on_tutor_subject_id", using: :btree
  end

  create_table "courses", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "course_prefix",                 null: false
    t.string  "course_code",                   null: false
    t.string  "course_name",                   null: false
    t.boolean "hidden",        default: false, null: false
    t.index ["course_code"], name: "idx_courses_code", using: :btree
    t.index ["course_prefix", "course_code"], name: "idx_courses_prefix_code", using: :btree
    t.index ["course_prefix", "course_code"], name: "idx_courses_prefix_code_unique_not_hidden", using: :btree
  end

  create_table "pending_tutor_requests", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "tutor_subject_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.bigint   "student_id",       null: false
    t.bigint   "tutor_id",         null: false
    t.index ["student_id", "created_at"], name: "idx_pending_student_created", using: :btree
    t.index ["tutor_id", "created_at"], name: "idx_pending_tutor_created", using: :btree
    t.index ["tutor_subject_id", "student_id"], name: "idx_pending_tutor_request", unique: true, using: :btree
  end

  create_table "tutor_subjects", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "course_id",                            null: false
    t.integer  "rate",       limit: 4,                 null: false
    t.boolean  "deleted",              default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.bigint   "user_id"
    t.index ["course_id"], name: "index_tutor_subjects_on_course_id", using: :btree
    t.index ["user_id", "created_at"], name: "idx_subjects_user_created", using: :btree
  end

  create_table "user_audits", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "user_id",      null: false
    t.string   "phone_number", null: false
    t.string   "action",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["phone_number"], name: "idx_audits_phone", using: :btree
    t.index ["user_id", "created_at"], name: "idx_audits_user_created", using: :btree
  end

  create_table "users", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider",                             default: "email", null: false
    t.string   "uid",                                  default: "",      null: false
    t.string   "encrypted_password",                   default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "app_token"
    t.string   "app_token_platform"
    t.integer  "agg_user_rating",        limit: 4,     default: 0,       null: false
    t.integer  "num_user_rating",        limit: 4,     default: 0,       null: false
    t.integer  "agg_tutor_rating",       limit: 4,     default: 0,       null: false
    t.integer  "num_tutor_rating",       limit: 4,     default: 0,       null: false
    t.boolean  "tutor_hidden",                         default: true,    null: false
    t.text     "tutor_description",      limit: 65535
    t.datetime "user_hidden_at"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["phone_number"], name: "idx_users_phone_unique", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "accepted_tutor_requests", "tutor_subjects", on_delete: :cascade
  add_foreign_key "accepted_tutor_requests", "users", column: "student_id", on_delete: :nullify
  add_foreign_key "accepted_tutor_requests", "users", column: "tutor_id", on_delete: :nullify
  add_foreign_key "pending_tutor_requests", "tutor_subjects", on_delete: :cascade
  add_foreign_key "pending_tutor_requests", "users", column: "student_id"
  add_foreign_key "pending_tutor_requests", "users", column: "tutor_id"
  add_foreign_key "tutor_subjects", "courses", on_delete: :cascade
  add_foreign_key "tutor_subjects", "users"
end
