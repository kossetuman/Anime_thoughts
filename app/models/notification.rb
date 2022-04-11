class Notification < ApplicationRecord
  
  default_scope->{order(created_at: :desc)}
  
  belongs_to :like, optional: true
  #belongs_to :comment, optional: true
  belongs_to :anime, optional: true
  
  belongs_to :follower, class_name: 'Relationship', foreign_key: 'follower_id', optional: true
  belongs_to :follwing,class_name: 'Relationship', foreign_key: 'following_id', optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
