# rubocop:disable Metrics/AbcSize
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
        notifcation_params = { 'user_id' => params[:id],
                               'title' => params[:notification_title],
                               'body' => params[:notification_body],
                               'icon' => params[:notification_icon],
                               'color' =>  params[:notification_color],
                               'type' =>   params[:notification_type],
                               'associated_data' => params[:associated_data] }
        Notifications.send_notification(notifcation_params)
      end
    end
  end
end
