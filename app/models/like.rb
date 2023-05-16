class Like < ApplicationRecord
  belongs_to :liker, foreign_key: :liker_id, class_name: :User
  belongs_to :likeable, polymorphic: true
  
  validates :liker_id, :likeable_type, :likeable_id, presence: true
  validates :liked, inclusion: { in: [true, false] }

  scope :by_likes, -> { where(liked: true) }
  scope :by_dislikes, -> { where(liked: false) }
end
