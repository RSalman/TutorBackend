# A tutor is willing to tutor a given course
class TutorSubject < ApplicationRecord
  validates :rate, presence: true
  validates :tutor_info, presence: true
  validates :course, presence: true
  belongs_to :tutor_info
  belongs_to :course
  has_many :tutor_requests

  def self.tutors_by_prefix_and_code(query)
    base = Course.select('*').joins(tutor_subjects: { tutor_info: :user })
    query = '' unless query
    /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ query
    if prefix != '' && code != ''
      base.where(course_prefix: prefix, course_code: code)
    elsif prefix != ''
      base.where(course_prefix: prefix)
    elsif code != ''
      base.where(course_code: code)
    else
      base
    end
  end
end
