# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersAcceptedTutorRequestsUpdate < ActiveRecord::Migration
  def up
    create_trigger("accepted_tutor_requests_after_update_of_tutor_rating_row_tr", :generated => true, :compatibility => 1).
        on("accepted_tutor_requests").
        after(:update).
        of(:tutor_rating) do
      <<-SQL_ACTIONS
UPDATE Users SET
     agg_tutor_rating = agg_tutor_rating + NEW.tutor_rating,
     num_tutor_rating = num_tutor_rating + 1
     WHERE id = NEW.tutor_id;
      SQL_ACTIONS
    end

    create_trigger("accepted_tutor_requests_after_update_of_student_rating_row_tr", :generated => true, :compatibility => 1).
        on("accepted_tutor_requests").
        after(:update).
        of(:student_rating) do
      <<-SQL_ACTIONS
UPDATE Users SET
     agg_user_rating = agg_user_rating + NEW.student_rating,
     num_user_rating = num_user_rating + 1
     WHERE id = NEW.student_id;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("accepted_tutor_requests_after_update_of_tutor_rating_row_tr", "accepted_tutor_requests", :generated => true)

    drop_trigger("accepted_tutor_requests_after_update_of_student_rating_row_tr", "accepted_tutor_requests", :generated => true)
  end
end
