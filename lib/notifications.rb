# Push Notification Util Lib
# rubocop:disable Metrics/AbcSize
module Notifications
  # Generate Push Notification with Firebase given user id.
  # TODO: Icon / data payload specification
  def send_notification(notifcation_params)
    user = User.find(notifcation_params['user_id'])
    # TODO: Timeout
    app_token = user.app_token

    if app_token.to_s.empty?    
      uri = URI.parse(FIREBASE_API)
      header = {
        :'Content-Type' => 'application/json',
        :Authorization => 'key=' + FIREBASE_SERVER_KEYS[user.app_token_platform]
      }
      body = {
        to: user.app_token,
        notification: {
          body: notifcation_params['body'],
          title: notifcation_params['title'],
          icon: notifcation_params['icon'],
          color: notifcation_params['color']
        },
        data: {
          type: notifcation_params['type'],
          associated_data: notifcation_params['associated_data']
        }
      }
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = body.to_json
      http.request(request)
      # TODO: Add error-handling
    end
  end
  module_function :send_notification
end
