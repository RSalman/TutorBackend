# A user of the application.
class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_one :tutor_info
end
