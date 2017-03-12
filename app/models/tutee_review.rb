# A tutor's review of a tutee
class TuteeReview < ApplicationRecord
  validates :rating, presence: true
  validates :tutor_request, presence: true
  belongs_to :tutor_request
end
