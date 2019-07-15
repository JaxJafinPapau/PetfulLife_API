class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username
  
  validates :email, uniqueness: true, presence: true

  has_many :pets
  has_many :user_products
  has_many :products, through: :user_products
end
