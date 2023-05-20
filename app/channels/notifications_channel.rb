class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{current_user.hashid}"
  end

  def unsubscribed
    stop_all_streams
  end
end
