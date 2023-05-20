class Video < ApplicationRecord
  attr_accessor :total_likes, :total_dislikes, :liked, :sharer_email
  belongs_to :sharer, foreign_key: :sharer_id, class_name: :User
  has_many :likes, as: :likeable, dependent: :destroy
  has_one :notification, dependent: :destroy

  validates :youtube_video_id, :title, :sharer_id, presence: true
  validates :youtube_video_id, uniqueness: { case_sensitive: false }, length: { is: 11 }
end
