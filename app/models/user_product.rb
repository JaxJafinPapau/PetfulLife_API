class UserProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  validates :rating, numericality: {only_integer: true}
end
