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

ActiveRecord::Schema.define(version: 20171002051645) do

  create_table "accepted_tutor_requests", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "tutor_subject_id",                                                null: false
    t.bigint   "student_id"
    t.bigint   "tutor_id"
    t.integer  "tutor_rating",     limit: 1
    t.integer  "student_rating",   limit: 1
    t.datetime "cr_at",                      default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["student_id", "cr_at"], name: "idx_accepted_student_cr", using: :btree
    t.index ["tutor_id", "cr_at"], name: "idx_accepted_tutor_cr", using: :btree
    t.index ["tutor_subject_id"], name: "index_accepted_tutor_requests_on_tutor_subject_id", using: :btree
  end

  create_table "courses", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "course_prefix", limit: 10,                 null: false
    t.string  "course_code",   limit: 10,                 null: false
    t.string  "course_name",                              null: false
    t.boolean "hidden",                   default: false
    t.index ["course_code"], name: "idx_courses_code", using: :btree
    t.index ["course_prefix", "course_code", "hidden"], name: "idx_courses_prefix_code_hidden_unique", unique: true, using: :btree
    t.index ["course_prefix", "course_code"], name: "idx_courses_prefix_code", using: :btree
  end

  create_table "pending_tutor_requests", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "tutor_subject_id",                                      null: false
    t.bigint   "student_id",                                            null: false
    t.bigint   "tutor_id",                                              null: false
    t.datetime "cr_at",            default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["student_id", "cr_at"], name: "idx_pending_student_cr", using: :btree
    t.index ["tutor_id", "cr_at"], name: "idx_pending_tutor_cr", using: :btree
    t.index ["tutor_subject_id", "student_id"], name: "idx_pending_tutor_request", unique: true, using: :btree
  end

  create_table "tutor_subjects", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "course_id",                                                 null: false
    t.integer  "rate",       limit: 4,                                      null: false
    t.bigint   "user_id"
    t.datetime "deleted_at"
    t.datetime "cr_at",                default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["course_id", "cr_at"], name: "idx_subjects_course_cr", using: :btree
    t.index ["user_id", "cr_at"], name: "idx_subjects_user_cr", using: :btree
  end

  create_table "user_audits", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "user_id",                                                      null: false
    t.string   "phone_number", limit: 15,                                      null: false
    t.string   "action",       limit: 10,                                      null: false
    t.datetime "created_at",              default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["phone_number"], name: "idx_audits_phone", using: :btree
    t.index ["user_id", "created_at"], name: "idx_audits_user_created", using: :btree
  end

  create_table "users", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider",                              default: "email",                    null: false
    t.string   "uid",                                   default: "",                         null: false
    t.string   "encrypted_password",                    default: "",                         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           limit: 4,     default: 0,                          null: false
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
    t.text     "tokens",                  limit: 65535
    t.datetime "created_at",                            default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at",                            default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "app_token"
    t.string   "app_token_platform"
    t.integer  "agg_user_rating",         limit: 4,     default: 0,                          null: false
    t.integer  "num_user_rating",         limit: 4,     default: 0,                          null: false
    t.integer  "agg_tutor_rating",        limit: 4,     default: 0,                          null: false
    t.integer  "num_tutor_rating",        limit: 4,     default: 0,                          null: false
    t.boolean  "tutor_hidden",                          default: true,                       null: false
    t.text     "tutor_description",       limit: 65535
    t.datetime "user_hidden_at"
    t.string   "tutor_short_description"
    t.string   "education"
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
  create_trigger("users_after_insert_row_tr", :generated => true, :compatibility => 1).
      on("users").
      after(:insert) do
    <<-SQL_ACTIONS

    INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "created",
      CURRENT_TIMESTAMP);
    SQL_ACTIONS
  end

  create_trigger("users_after_delete_row_tr", :generated => true, :compatibility => 1).
      on("users").
      after(:delete) do
    <<-SQL_ACTIONS

    INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (OLD.id, OLD.phone_number, "deleted",
    CURRENT_TIMESTAMP);
    SQL_ACTIONS
  end

  create_trigger("accepted_tutor_requests_after_update_row_tr", :generated => true, :compatibility => 1).
      on("accepted_tutor_requests").
      after(:update) do
    <<-SQL_ACTIONS

    IF OLD.tutor_rating IS NULL AND NEW.tutor_rating IS NOT NULL THEN
      UPDATE users
      SET agg_tutor_rating = agg_tutor_rating + NEW.tutor_rating, num_tutor_rating = num_tutor_rating + 1
      WHERE id = NEW.tutor_id;
    END IF;
    IF OLD.student_rating IS NULL AND NEW.student_rating IS NOT NULL THEN
      UPDATE users
      SET agg_user_rating = agg_user_rating + NEW.student_rating, num_user_rating = num_user_rating + 1
      WHERE id = NEW.student_id;
    END IF;
    SQL_ACTIONS
  end

  create_trigger("users_after_update_row_tr", :generated => true, :compatibility => 1).
      on("users").
      after(:update) do
    <<-SQL_ACTIONS

    IF OLD.user_hidden_at IS NULL AND NEW.user_hidden_at IS NOT NULL THEN
      INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "hidden",
        CURRENT_TIMESTAMP);
      UPDATE tutor_subjects
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE user_id = NEW.id AND deleted_at IS NULL;
    ELSEIF OLD.user_hidden_at IS NOT NULL and NEW.user_hidden_at IS NULL THEN
      INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "unhidden",
        CURRENT_TIMESTAMP);
    END IF;
    IF OLD.tutor_hidden = FALSE AND NEW.tutor_hidden = TRUE THEN
      UPDATE tutor_subjects
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE user_id = NEW.id AND deleted_at IS NULL;
    END IF;
    SQL_ACTIONS
  end

  create_trigger("courses_after_update_row_tr", :generated => true, :compatibility => 1).
      on("courses").
      after(:update) do
    <<-SQL_ACTIONS

    IF OLD.hidden = FALSE AND NEW.hidden IS NULL THEN
      UPDATE tutor_subjects AS x
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE course_id = NEW.id AND deleted_at IS NULL;
    END IF;
    SQL_ACTIONS
  end

end
