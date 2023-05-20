require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection(current_user: user)
    subscribe
  end

  it 'subscribes to the user-specific notifications channel' do
    expect(subscription).to be_confirmed
    expect(subscription.streams).to include("notifications:#{user.hashid}")
  end

  it 'unsubscribes from all streams' do
    unsubscribe
    expect(subscription.streams).to be_empty
  end
end

