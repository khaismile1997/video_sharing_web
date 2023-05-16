require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_length_of(:username).is_at_least(3).is_at_most(25) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:email).is_at_most(105) }
    it { is_expected.to allow_value('abc@gmail.com').for(:email) }
    it { is_expected.not_to allow_value('abc').for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:shared_videos).with_foreign_key(:sharer_id).class_name('Video') }
    it { is_expected.to have_many(:likes).with_foreign_key(:liker_id).class_name('Like') }
  end

  describe 'callbacks' do
    it 'downcases the email before saving' do
      user.email = 'ABC@GMAIL.COM'
      user.save
      expect(user.email).to eq('abc@gmail.com')
    end

    it 'ensures session token before validation' do
      user.save
      expect(user.session_token).not_to be_nil
    end
  end

  describe '.generate_session_token' do
    it 'generates a secure session token' do
      session_token = User.generate_session_token
      expect(session_token).to be_a(String)
      expect(session_token.length).to eq(22)
    end
  end

  describe '#ensure_session_token' do
    it 'assigns a session token if it is not present' do
      user.session_token = nil
      user.ensure_session_token
      expect(user.session_token).not_to be_nil
    end

    it 'does not assign a new session token if it is already present' do
      user.ensure_session_token
      session_token = user.session_token
      user.ensure_session_token
      expect(user.session_token).to eq(session_token)
    end
  end

  describe '#reset_session_token!' do
    it 'resets the session token' do
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_session_token)
    end

    it 'saves the user with the new session token' do
      user.reset_session_token!
      expect(user).to be_persisted
      expect(user.session_token).to eq(user.reload.session_token)
    end
  end
end
