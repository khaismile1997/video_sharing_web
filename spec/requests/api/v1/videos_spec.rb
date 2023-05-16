require 'rails_helper'

RSpec.describe 'Videos', type: :request do
  describe 'GET /api/v1/videos' do
    it 'returns a list of videos' do
      create_list(:video, 10)
      get api_v1_videos_path, params: { page: 1 }
      expect(response).to have_http_status(:ok)

      videos = JSON.parse(response.body)
      expect(videos['data'].length).to eq(10)
    end
  end

  describe 'POST /api/v1/videos' do
    include_context "when user has signed in"

    it 'creates a new video' do
      youtube_id = Faker::Alphanumeric.alphanumeric(number: 11)
      video_url = "https://www.youtube.com/watch?v=#{youtube_id}"
      video_info = JSON.parse({
        items: [{ id: youtube_id, snippet: { localized: { title: 'Test Title', description: 'Test Description' } } }]
      }.to_json, object_class: OpenStruct)
      allow(GoogleApi::Client).to receive(:get_video_info).and_return(video_info)

      expect {
        post api_v1_videos_path, params: { url: video_url }
      }.to change(Video, :count).by(1)

      expect(response).to have_http_status(:ok)

      expected_video = {
        youtube_video_id: youtube_id,
        title: 'Test Title',
        description: 'Test Description',
        sharer_id: user.id,
      }
      result = Video.first.attributes.symbolize_keys.slice(:youtube_video_id, :title, :description, :sharer_id)
      expect(result).to eq(expected_video)
    end

    it 'returns an error when the video URL is invalid' do
      youtube_id = Faker::Alphanumeric.alphanumeric(number: 11)
      invalid_url = "https://www.youtube.com/watch?v=#{youtube_id}"
      video_info = JSON.parse({items: []}.to_json, object_class: OpenStruct)
      allow(GoogleApi::Client).to receive(:get_video_info).and_return(video_info)

      expect {
        post api_v1_videos_path, params: { url: invalid_url }
      }.not_to change(Video, :count)

      expect(response).to have_http_status(:not_found)

      error_response = JSON.parse(response.body)
      expect(error_response['error']['message']).to eq I18n.t("api_error.video_not_existed")
    end
  end
end
