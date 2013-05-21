class Comment < ActiveRecord::Base
  attr_accessible :body, :post_id, :user_id
  
  validates :body, presence: true, length: { minimum: 1, maximum: 500 }
  validates :user_id, presence: true

  belongs_to :post
  belongs_to :user
end
