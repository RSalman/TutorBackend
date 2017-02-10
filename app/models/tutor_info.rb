# A user's tutor-specific information
class TutorInfo < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  has_many :tutor_subjects
end
