class Anime < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :anime_image

  validates :title, presence: true

end
