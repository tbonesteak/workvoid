class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: true, length: {
    minimum: 3,
    maximum: 20
  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  

  extend FriendlyId
  friendly_id :username, use: :slugged

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :admin
  # attr_accessible :title, :body

  has_many :posts
  has_many :comments
end
