module Api
  module V1
    # Verifies a user's phone number by sending a code to them via sms
    class PhoneVerificationController < ApplicationController
      respond_to :json

      # Starts the verification process, only needs a phone number
      def start
        response = Authy::PhoneVerification.start(
          via: 'sms',
          country_code: 1,
          phone_number: params[:phone]
        )
        render json: response
      end

      # Verify if the code that the user provided is correct
      def check
        response = Authy::PhoneVerification.check(
          verification_code: params[:verification_code],
          country_code: 1,
          phone_number: params[:phone]
        )
        render json: response
      end
    end
  end
end
