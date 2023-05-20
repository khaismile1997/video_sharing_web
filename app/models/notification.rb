class Notification < ApplicationRecord
  after_commit -> { NotificationBroadcastJob.perform_now(self) }
  belongs_to :video
end
