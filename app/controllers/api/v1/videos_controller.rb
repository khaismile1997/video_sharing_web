class Api::V1::VideosController < Api::V1::BaseController

  def index
    videos = Video.paginate(page: params[:page], per_page: 10)
    render json: videos, each_serializer: VideoSerializer
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