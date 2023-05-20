class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    video = notification.video
    notification_info = { video_title: video.title, sharer_email: video.sharer.email }
    ActionCable.server.broadcast('notifications', notification_info)
  end
end
