# A tutor is willing to tutor a given course
class TutorSubject < ApplicationRecord
  validates :rate, presence: true
  validates :tutor_info, presence: true
  validates :course, presence: true
  belongs_to :tutor_info
  belongs_to :course

  def self.tutors_by_prefix_and_code(course_prefix, course_code)
    base = Course.select('*').joins(tutor_subjects: { tutor_info: :user })
    if course_prefix && course_code
      base.where(course_prefix: course_prefix, course_code: course_code)
    elsif course_prefix
      base.where(course_prefix: course_prefix)
    elsif course_code
      base.where(course_code: course_code)
    else
      base
    end
  end
end
