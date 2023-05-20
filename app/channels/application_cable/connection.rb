module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verfied_user
    end

    protected

    def find_verfied_user
      session_token = request.session[:session_token]
      user = User.find_by(session_token: session_token)
      return if user
      raise ApiError::Unauthorized
    end
  end
end
