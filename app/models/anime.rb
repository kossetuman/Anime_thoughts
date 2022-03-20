class Anime < ApplicationRecord

  attachment :anime_image

  belongs_to :user

  validates :title, presence: true

end
