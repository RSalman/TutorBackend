# A tutee's review of a tutor
class TutorReview < ApplicationRecord
  validates :rating, presence: true
  validates :tutor_request, presence: true
  belongs_to :tutor_request
end
