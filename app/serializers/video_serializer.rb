class VideoSerializer < ApplicationSerializer
  VIDEO_ATTRS = %i(
    url
    title
    description
    liked
    total_likes
    total_dislikes
  ).freeze

  attributes :id, *VIDEO_ATTRS

  def url
    extract_youtube_url(object.youtube_video_id)
  end

  def total_likes
    object.total_likes || 0
  end

  def total_dislikes
    object.total_dislikes || 0
  end
end
