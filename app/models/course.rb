# A course
class Course < ApplicationRecord
  validates :course_prefix, presence: true, length: { maximum: 10 }
  validates :course_code, presence: true, length: { maximum: 10 }
  validates :course_name, presence: true
  has_many :tutor_subjects

  trigger.after(:update) do
    '
    IF OLD.hidden = FALSE AND NEW.hidden = TRUE THEN
      UPDATE tutor_subjects AS x
      INNER JOIN (
        SELECT user_id, max(cr_at) AS time FROM tutor_subjects
        WHERE course_id = NEW.id GROUP BY user_id) AS y
      ON x.user_id = y.user_id AND x.cr_at = y.time
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE course_id = NEW.id AND deleted_at IS NULL;
    END IF;'
  end
end
