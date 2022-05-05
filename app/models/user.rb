class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: {男: 0, 女: 1}

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

  #通知機能のアソシエーション
  
  #自分からの通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
 
  #相手からの通知
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  attachment :image

  validates :name,
    presence: true,
    length: { in: 1..10}

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

 #すでにいいねをしているか確認
  def already_liked?(anime)
    self.likes.exists?(anime_id: anime.id)
  end

  def create_notification_follow(current_user)
    #すでにフォローされているか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    #フォローされていなかった場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save
    end
  end

  #論理削除 is_activeがfalseならtrueを返す
  def active_for_authentication?
    super && (is_active == false)
  end
  
  def current_user
    
  end  

end
