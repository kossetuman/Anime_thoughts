class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: {man: 1, woman: 2}

  has_many :animes, dependent: :destroy
  
  #コメント機能のアソシエーション
  has_many :comments, dependent: :destroy
  
  #いいね機能のアソシエーション
  has_many :likes, dependent: :destroy

  #フォロー機能のアソシエーション
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  attachment :image

  validates :name,
    presence: true,
    length: { in: 1..8}
  
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end  
  
  def already_liked?(anime)
    self.likes.exists?(anime_id: anime.id)
  end  

end
