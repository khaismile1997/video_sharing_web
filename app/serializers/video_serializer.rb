class VideoSerializer < ApplicationSerializer
  VIDEO_ATTRS = %i(
    url
    title
    description
  ).freeze

  attributes :id, *VIDEO_ATTRS

  def url
    extract_youtube_url(object.youtube_video_id)
  end
end