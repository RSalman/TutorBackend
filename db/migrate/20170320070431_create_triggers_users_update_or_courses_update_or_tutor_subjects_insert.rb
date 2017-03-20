# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersUsersUpdateOrCoursesUpdateOrTutorSubjectsInsert < ActiveRecord::Migration
  def up
    drop_trigger("users_after_update_row_tr", "users", :generated => true)

    drop_trigger("courses_after_update_row_tr", "courses", :generated => true)

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

    create_trigger("tutor_subjects_before_insert_row_tr", :generated => true, :compatibility => 1).
        on("tutor_subjects").
        before(:insert) do
      <<-SQL_ACTIONS

    UPDATE tutor_subjects
    SET deleted_at = CURRENT_TIMESTAMP
    WHERE course_id = NEW.course_id AND user_id = NEW.user_id AND deleted_at IS NULL;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("users_after_update_row_tr", "users", :generated => true)

    drop_trigger("courses_after_update_row_tr", "courses", :generated => true)

    drop_trigger("tutor_subjects_before_insert_row_tr", "tutor_subjects", :generated => true)

    create_trigger("users_after_update_row_tr", :generated => true, :compatibility => 1).
        on("users").
        after(:update) do
      <<-SQL_ACTIONS

    IF OLD.user_hidden_at IS NULL AND NEW.user_hidden_at IS NOT NULL THEN
      INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "hidden",
        CURRENT_TIMESTAMP);
      UPDATE tutor_subjects AS x
      INNER JOIN (
        SELECT course_id, max(cr_at) AS time FROM tutor_subjects
        WHERE user_id = NEW.id GROUP BY course_id) AS y
      ON x.course_id = y.course_id AND x.cr_at = y.time
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE user_id = NEW.id AND deleted_at IS NULL;
    ELSEIF OLD.user_hidden_at IS NOT NULL and NEW.user_hidden_at IS NULL THEN
      INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "unhidden",
        CURRENT_TIMESTAMP);
    END IF;
    IF OLD.tutor_hidden = FALSE AND NEW.tutor_hidden = TRUE THEN
      UPDATE tutor_subjects AS x
      INNER JOIN (
        SELECT course_id, max(cr_at) AS time FROM tutor_subjects
        WHERE user_id = NEW.id GROUP BY course_id) AS y
      ON x.course_id = y.course_id AND x.cr_at = y.time
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
      INNER JOIN (
        SELECT user_id, max(cr_at) AS time FROM tutor_subjects
        WHERE course_id = NEW.id GROUP BY user_id) AS y
      ON x.user_id = y.user_id AND x.cr_at = y.time
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE course_id = NEW.id AND deleted_at IS NULL;
    END IF;
      SQL_ACTIONS
    end
  end
end
