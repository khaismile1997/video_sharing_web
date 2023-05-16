class Video < ApplicationRecord

  belongs_to :sharer, foreign_key: :sharer_id, class_name: :User
  has_many :likes, as: :likeable, dependent: :destroy

  validates :youtube_video_id, :title, :sharer_id, presence: true
  validates :youtube_video_id, uniqueness: { case_sensitive: false }, length: { is: 11 }
end
