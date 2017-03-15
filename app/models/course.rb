# A course
class Course < ApplicationRecord
  validates :course_prefix, presence: true
  validates :course_code, presence: true
  validates :course_name, presence: true
  has_many :tutor_subjects
end
