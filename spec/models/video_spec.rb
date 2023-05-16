require "rails_helper"

RSpec.describe Video, type: :model do
  subject(:video) { build(:video) }

  describe 'associations' do
    it { is_expected.to belong_to(:sharer).class_name('User').with_foreign_key(:sharer_id) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:youtube_video_id) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:sharer_id) }
    it { is_expected.to validate_uniqueness_of(:youtube_video_id).case_insensitive }
    it { is_expected.to validate_length_of(:youtube_video_id).is_equal_to(11) }
  end
end
