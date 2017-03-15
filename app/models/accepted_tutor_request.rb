# An accepted request from a user for a particular instance of a TutorSubject (student and tutor can be nulled)
class AcceptedTutorRequest < ApplicationRecord
  validates :tutor_subject, presence: true
  validates :tutor_rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, :allow_nil => true
  validates :student_rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, :allow_nil => true
  belongs_to :tutor_subject
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'
end
