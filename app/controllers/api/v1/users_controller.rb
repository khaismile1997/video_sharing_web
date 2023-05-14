class Api::V1::UsersController < Api::V1::BaseController

  def create
    user = User.new(user_params)
    raise ApiError::RecordInvalid, user if user.invalid?
    user.save!
    login!(user)
    render json: user, serializer: UserSerializer
  end

  def show
    user = User.find_by_hashid!(params[:id])
    render json: user, serializer: UserSerializer
  end

  private

  def user_params
    params.require(:user).permit(:username, :email).merge(params.permit(:password))
  end
end
