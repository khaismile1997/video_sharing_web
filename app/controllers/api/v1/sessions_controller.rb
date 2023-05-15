class Api::V1::SessionsController < Api::V1::BaseController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      login!(user)
      render json: user, serializer: UserSerializer
    else
      msg = I18n.t("api_error.invalid_login")
      raise ActiveRecord::RecordNotFound, msg
    end
  end

  def destroy
    if current_user
      logout!
      render json: success_message(I18n.t("messages.success.logout")) and return
    end
    msg = I18n.t("api_error.invalid_logout")
    raise ActiveRecord::RecordNotFound, msg
  end
end