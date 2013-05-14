class Post < ActiveRecord::Base
  attr_accessible :description, :approved

  validates :description, presence: true, length: { minimum: 30, maximum: 4000 }

  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true
end
