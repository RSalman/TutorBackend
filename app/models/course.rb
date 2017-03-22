# A course
class Course < ApplicationRecord
  validates :course_prefix, presence: true, length: { maximum: 10 }
  validates :course_code, presence: true, length: { maximum: 10 }
  validates :course_name, presence: true
  has_many :tutor_subjects

  # When a Course is hidden, automatically deletes all TutorSubjects referencing it by updating their deleted_at fields
  # to CURRENT_TIMESTAMP
  trigger.after(:update) do
    '
    IF OLD.hidden = FALSE AND NEW.hidden IS NULL THEN
      UPDATE tutor_subjects AS x
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE course_id = NEW.id AND deleted_at IS NULL;
    END IF;'
  end
end
