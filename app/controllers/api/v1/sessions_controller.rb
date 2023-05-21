class Api::V1::SessionsController < Api::V1::BaseController

  def create
    if logged_in?
      render json: current_user, serializer: UserSerializer
      return
    end

    user = User.find_by(email: params[:session][:email]&.downcase)
    if user&.authenticate(params[:session][:password])
      login!(user)
      render json: user, serializer: UserSerializer
    else
      msg = I18n.t("api_error.invalid_login")
      raise ApiError::Auth::Unauthorized, msg
    end
  end

  def destroy
    if current_user
      logout!
      render json: success_message(I18n.t("messages.success.logout")) and return
    end
    msg = I18n.t("api_error.invalid_logout")
    raise ApiError::Auth::Unauthorized, msg
  end
end