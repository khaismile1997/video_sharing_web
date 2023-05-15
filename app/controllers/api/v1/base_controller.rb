class Api::V1::BaseController < ApplicationController
  helper_method :current_user, :logged_in?
  skip_before_action :verify_authenticity_token

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token]) if session[:session_token]
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
end
