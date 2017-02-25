# A course
class Course < ApplicationRecord
  validates :course_prefix, :course_code, :course_name, presence: true
  has_many :tutor_subjects

  def self.course_by_prefix_and_code(course_prefix, course_code)
    if course_prefix && course_code
      Course.where(course_prefix: course_prefix, course_code: course_code)
    elsif course_prefix
      Course.where(course_prefix: course_prefix)
    elsif course_code
      Course.where(course_code: course_code)
    else
      []
    end
  end
end
