# A user of the application.
class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :tutor_subjects
  has_many :pending_tutor_requests
  has_many :accepted_tutor_requests
end
