# A request from a user for a particular instance of a TutorSubject (can have since been voided)
class PendingTutorRequest < ApplicationRecord
  validates :tutor_subject, presence: true
  validates :student, presence: true
  validates :tutor, presence: true
  belongs_to :tutor_subject
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'
end
