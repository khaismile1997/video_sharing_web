class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    video = notification.video
    ActionCable.server.broadcast('notifications',
      notification: { video_title: video.title, sharer_email: video.sharer.email }
    )
  end
end
