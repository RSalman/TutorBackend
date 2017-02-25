# A course
class Course < ApplicationRecord
  validates :course_prefix, :course_code, :course_name, presence: true
  has_many :tutor_subjects
end
