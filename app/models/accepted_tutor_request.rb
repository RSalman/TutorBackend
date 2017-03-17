# An accepted request from a user for a particular instance of a TutorSubject (student and tutor can be nulled)
class AcceptedTutorRequest < ApplicationRecord
  validates :tutor_subject, presence: true
  validates :tutor_rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, :allow_nil => true
  validates :student_rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, :allow_nil => true
  belongs_to :tutor_subject
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'

  # This trigger assumes ratings are only given once and cannot be updated
  # Updates the User/Tutor's aggregate rating whenever a rating is left
  trigger.after(:update) do
    '
    IF OLD.tutor_rating IS NULL AND NEW.tutor_rating IS NOT NULL THEN
      UPDATE users
      SET agg_tutor_rating = agg_tutor_rating + NEW.tutor_rating, num_tutor_rating = num_tutor_rating + 1
      WHERE id = NEW.tutor_id;
    END IF;
    IF OLD.student_rating IS NULL AND NEW.student_rating IS NOT NULL THEN
      UPDATE users
      SET agg_user_rating = agg_user_rating + NEW.student_rating, num_user_rating = num_user_rating + 1
      WHERE id = NEW.student_id;
    END IF;'
  end
end
