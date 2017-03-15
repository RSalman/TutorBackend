# Push Notification Util Lib
module Notifications
  # Generate Push Notification with Firebase given user id.
  # TODO: Icon / data payload specification
  def send_notification(user_id, notification_title, notification_body)
    user = User.find(user_id)
    # TODO: Timeout
    uri = URI.parse(FIREBASE_API)
    header = {
      :'Content-Type' => 'application/json',
      :Authorization => 'key=' + FIREBASE_SERVER_KEYS[user.app_token_platform]
    }
    body = {
      to: user.app_token,
      notification: {
        body: notification_body,
        title: notification_title
      }
    }
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json
    http.request(request)
    # TODO: Add error-handling
  end
  module_function :send_notification
end
