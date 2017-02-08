# A tutor is willing to tutor a given course
class TutorSubject < ApplicationRecord
  belongs_to :tutor_info
  belongs_to :course
end
