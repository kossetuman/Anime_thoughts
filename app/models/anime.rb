class Anime < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true

  validates :thought,
    presence: true,
    length: {maximum: 2000}

  validates :rate, presence: true


end
