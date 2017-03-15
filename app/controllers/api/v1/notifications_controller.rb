require_dependency 'Notifications'
module Api
  module V1
    # Set/Update user's app token for push notifications
    class NotificationsController < ApplicationController
      # Endpoint to update user's token in DB
      def set_app_token
        user = User.find(params[:id])
        token_data = params[:token_data]
        updated = user.update(app_token: token_data[:app_token], app_token_platform: token_data[:app_token_platform])
        # TODO: Add error-handling
        json_response('updated' => updated)
      end

      # Temp Endpoint to generate notifications
      def generate_notification
        Notifications.send_notification(params[:id], params[:notification_title], params[:notification_body])
      end
    end
  end
end
