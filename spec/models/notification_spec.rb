require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'after_commit callback' do
    let(:video) { create(:video) }
    let(:notification) { Notification.new(video: video) }

    it 'calls the NotificationBroadcastJob' do
      expect(NotificationBroadcastJob).to receive(:perform_later).with(notification)
      notification.save!
    end
  end
end

