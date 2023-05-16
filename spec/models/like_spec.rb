require "rails_helper"

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:liker).class_name('User').with_foreign_key(:liker_id) }
    it { is_expected.to belong_to(:likeable) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:liker_id) }
    it { is_expected.to validate_presence_of(:likeable_type) }
    it { is_expected.to validate_presence_of(:likeable_id) }
  end
end
