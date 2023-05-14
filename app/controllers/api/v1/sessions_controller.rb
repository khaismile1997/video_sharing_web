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
    return logout! if current_user
    msg = I18n.t("api_error.invalid_logout")
    raise ActiveRecord::RecordNotFound, msg
  end
end