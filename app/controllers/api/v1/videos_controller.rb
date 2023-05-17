class Api::V1::VideosController < Api::V1::BaseController
  before_action :authenticate_user!, only: %i(create)
  PER_PAGE = 10

  def index
    videos = Video.includes(:likes).paginate(page: params[:page], per_page: PER_PAGE)
    video_ids = videos.map(&:id)

    like_counts = Like.by_likes.where(likeable_type: 'Video', likeable_id: video_ids).group(:likeable_id).count
    dislike_counts = Like.by_dislikes.where(likeable_type: 'Video', likeable_id: video_ids).group(:likeable_id).count

    liked_disliked_videos = current_user&.likes
                                        &.where(likeable_id: video_ids, likeable_type: 'Video')&.pluck(:likeable_id, :liked)
                                        &.to_h

    videos.each do |video|
      video.total_likes = like_counts[video.id].to_i
      video.total_dislikes = dislike_counts[video.id].to_i
      video.liked = liked_disliked_videos&.fetch(video.id, nil)
    end

    render json: videos, each_serializer: VideoSerializer,
           meta: { total_pages: videos.total_pages, per_page: videos.per_page }
  end

  def create
    video_id = extract_video_id(params[:url])
    video_info = GoogleApi::Client.get_video_info(video_id)
    raise ApiError::Youtube::VideoNotExisted, I18n.t("api_error.video_not_existed") if video_info.items.blank?
    video_params = extract_video_params(video_info)
    video = Video.new(video_params)
    raise ApiError::RecordInvalid, video if video.invalid?
    video.save!
    render json: video, serializer: VideoSerializer
  end

  private

  def extract_video_id(url)
    regex = %r{(?:youtube(?:-nocookie)?\.com/(?:[^/\n\s]+/\S+/|(?:v|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/)([a-zA-Z0-9_-]{11})}
    match = url.match(regex)
    match[1] if match
  end

  def extract_video_params(video_info)
    video_obj = video_info.items.first
    localized = video_obj.snippet.localized
    {
      youtube_video_id: video_obj.id,
      title: localized.title,
      description: localized.description,
      sharer_id: current_user.id
    }
  end
end