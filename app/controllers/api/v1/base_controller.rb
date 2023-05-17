class Api::V1::BaseController < ApplicationController
  helper_method :current_user
  skip_before_action :verify_authenticity_token

  def current_user
    @current_user ||= User.find_by(session_token: access_token) if access_token
  end

  def authenticate_user!
    raise ApiError::Unauthorized unless current_user
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    @current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  protected

  def success_message(message)
    ResponseTemplate.success(message)
  end

  private

  def access_token
    extract_access_token(request.authorization) || session[:session_token]
  end

  def extract_access_token(token)
    token.to_s.match(/Bearer\s+(.+)/)&.captures&.first
  end
end
