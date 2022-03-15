class Anime < ApplicationRecord

  attachment :anime_image

  belongs_to :user

  validates :title, presence: true
  validates :thought, presence: true

end
