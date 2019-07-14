class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username,
                        :password_digest
  validates :email, uniqueness: true, presence: true

  has_many :pets
  has_many :user_products
  has_many :products, through: :user_products
end
