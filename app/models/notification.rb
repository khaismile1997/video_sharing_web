class Notification < ApplicationRecord
  after_commit -> { NotificationBroadcastJob.perform_later(self) }
  belongs_to :video
end
