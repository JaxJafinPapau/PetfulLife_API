class Product < ApplicationRecord
  has_many :pet_products
  has_many :pets, through: :pet_products
  has_many :user_products
  has_many :users, through: :user_products

  validates_presence_of :name

  validates :avg_price, numericality: {only_float: true}
  validates :upc, numericality: {only_integer: true}

end
