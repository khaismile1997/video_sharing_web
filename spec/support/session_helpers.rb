module SessionHelpers
  def generate_fake_session_token
    SecureRandom::urlsafe_base64
  end
end