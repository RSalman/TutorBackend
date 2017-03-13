# A request from a user for a particular instance of a TutorSubject (can have since been voided)
class PendingTutorRequest < ApplicationRecord
  has_one :tutor_subject
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'
end
