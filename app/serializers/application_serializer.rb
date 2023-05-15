class ApplicationSerializer < ActiveModel::Serializer
  YOUTUBE_BASE_URL = Settings.youtube.base_url

  type :data

  def id
    object.try(:hashid)
  end

  def extract_youtube_url(video_id)
    "#{YOUTUBE_BASE_URL}watch?v=#{video_id}"
  end
end
