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

  trigger.after(:insert) do
    '
    INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "created",
      CURRENT_TIMESTAMP);'
  end

  trigger.after(:update) do
    '
    IF OLD.user_hidden_at IS NULL AND NEW.user_hidden_at IS NOT NULL THEN
      INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "hidden",
        CURRENT_TIMESTAMP);

    ELSEIF OLD.user_hidden_at IS NOT NULL and NEW.user_hidden_at IS NULL THEN
      INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (NEW.id, NEW.phone_number, "unhidden",
        CURRENT_TIMESTAMP);
    END IF;
    IF OLD.tutor_hidden = FALSE AND NEW.tutor_hidden = TRUE THEN

    END IF;'
  end

  trigger.after(:delete) do
    '
    INSERT INTO user_audits (user_id, phone_number, action, created_at) VALUES (OLD.id, OLD.phone_number, "deleted",
    CURRENT_TIMESTAMP);'
  end
end
