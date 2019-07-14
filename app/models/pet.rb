class Pet < ApplicationRecord
  validates_presence_of :name,
                        :archetype,
                        :breed
  belongs_to :user
  has_many :pet_products
  has_many :products, through: :pet_products
end
