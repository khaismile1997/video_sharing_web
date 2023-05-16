require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :request do
  let!(:video) { create(:video) }

  describe 'POST /api/v1/videos/:id/like' do
    context 'when user is authenticated' do
      include_context "when user has signed in"

      it 'likes the video' do
        post "/api/v1/videos/#{video.hashid}/like"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(I18n.t('messages.success.like'))
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized' do
        post "/api/v1/videos/#{video.hashid}/like"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/videos/:id/unlike' do
    context 'when user is authenticated' do
      include_context "when user has signed in"
      let!(:like) { create(:like, liker: user, likeable: video, liked: true) }

      it 'unlikes the video' do
        delete "/api/v1/videos/#{video.hashid}/unlike"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(I18n.t('messages.success.unlike'))
      end

      context 'when unlikes the video is disliked' do
        before do
          like.update(liked: false)
        end

        it 'raise error' do
          delete "/api/v1/videos/#{video.hashid}/unlike"
          expect(response).to have_http_status(:not_found)
          expect(response.body).to include(I18n.t('api_error.invalid_unlike'))
        end
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized' do
        delete "/api/v1/videos/#{video.hashid}/unlike"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/videos/:id/dislike' do
    context 'when user is authenticated' do
      include_context "when user has signed in"

      it 'dislikes the video' do
        post "/api/v1/videos/#{video.hashid}/dislike"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(I18n.t('messages.success.dislike'))
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized' do
        post "/api/v1/videos/#{video.hashid}/dislike"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/videos/:id/undislike' do
    context 'when user is authenticated' do
      include_context 'when user has signed in'
      let!(:like) { create(:like, liker: user, likeable: video, liked: false) }

      it 'undislikes the video' do
        delete "/api/v1/videos/#{video.hashid}/undislike"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(I18n.t('messages.success.undislike'))
      end

      context 'when undislikes the video is liked' do
        before do
          like.update(liked: true)
        end

        it 'raise error' do
          delete "/api/v1/videos/#{video.hashid}/undislike"
          expect(response).to have_http_status(:not_found)
          expect(response.body).to include(I18n.t('api_error.invalid_undislike'))
        end
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized' do
        delete "/api/v1/videos/#{video.id}/undislike"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
