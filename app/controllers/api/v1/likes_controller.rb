class Api::V1::LikesController < Api::V1::BaseController
  before_action :authenticate_user!
  before_action :set_video, only: %i(like unlike dislike undislike)

  def like
    like = current_user.likes.find_or_initialize_by(likeable: @video, likeable_type: "Video")
    like.liked = true
    raise ApiError::RecordInvalid, like if like.invalid?
    like.save!
    render json: success_message(I18n.t("messages.success.like"))
  end

  def unlike
    like = current_user.likes.find_by(likeable: @video)
    raise ActiveRecord::RecordNotFound, I18n.t("api_error.invalid_unlike") unless like&.liked && like&.destroy
    render json: success_message(I18n.t("messages.success.unlike"))
  end

  def dislike
    like = current_user.likes.find_or_initialize_by(likeable: @video, likeable_type: "Video")
    like.liked = false
    raise ApiError::RecordInvalid, like if like.invalid?
    like.save!
    render json: success_message(I18n.t("messages.success.dislike"))
  end

  def undislike
    like = current_user.likes.find_by(likeable: @video)
    raise ActiveRecord::RecordNotFound, I18n.t("api_error.invalid_undislike") unless !like&.liked && like&.destroy
    render json: success_message(I18n.t("messages.success.undislike"))
  end

  private

  def set_video
    @video = Video.find_by_hashid!(params[:id])
  end
end