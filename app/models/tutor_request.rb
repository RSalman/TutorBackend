# A request from a user for a particular instance of a TutorSubject (can have since been voided)
class TutorRequest < ApplicationRecord
  has_one :tutor_review
  has_one :tutee_review
  belongs_to :user
  belongs_to :tutor_subject
end
