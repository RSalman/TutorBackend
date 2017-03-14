module Api
  module V1
    # Set/Update user's app token for push notifications
    class NotificationsController < ApplicationController
      respond_to :json

      # Endpoint to update user's token in DB
      def set_app_token
        user = User.find(params[:id])
        token_data = params[:token_data]
        updated = user.update(app_token: token_data[:app_token], app_token_platform: token_data[:app_token_platform])
        send_notification(1, 'test', 'test')
        # TODO: Add error-handling
        json_response('updated' => updated)
      end
    end
  end
end
