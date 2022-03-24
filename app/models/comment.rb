class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :anime
  
  validates :comment, presence: :true
end