# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersMultipleTables < ActiveRecord::Migration
  def up
    create_trigger("users_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("users").
        after(:insert) do
      <<-SQL_ACTIONS

    INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "created",
      CURRENT_TIMESTAMP);
      SQL_ACTIONS
    end

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

    create_trigger("courses_after_update_row_tr", :generated => true, :compatibility => 1).
        on("courses").
        after(:update) do
      <<-SQL_ACTIONS

    IF OLD.hidden = FALSE AND NEW.hidden = TRUE THEN
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

  def down
    drop_trigger("users_after_insert_row_tr", "users", :generated => true)

    drop_trigger("users_after_update_row_tr", "users", :generated => true)

    drop_trigger("users_after_delete_row_tr", "users", :generated => true)

    drop_trigger("accepted_tutor_requests_after_update_row_tr", "accepted_tutor_requests", :generated => true)

    drop_trigger("courses_after_update_row_tr", "courses", :generated => true)
  end
end
