# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerCoursesUpdate < ActiveRecord::Migration
  def up
    drop_trigger("courses_after_update_row_tr", "courses", :generated => true)

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

  def down
    drop_trigger("courses_after_update_row_tr", "courses", :generated => true)

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
end
