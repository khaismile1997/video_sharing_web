class User < ApplicationRecord

  before_save { self.email = email.downcase }
  before_validation :ensure_session_token

  has_many :likes, foreign_key: :liker_id, class_name: :Like

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :username, length: {minimum: 3, maximum: 25}, if: :username?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :email, length: {maximum: 105},
                    format: {with: VALID_EMAIL_REGEX}, if: :email?

  has_secure_password

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

end
