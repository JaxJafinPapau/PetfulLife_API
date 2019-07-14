class PetProduct < ApplicationRecord
  belongs_to :pet
  belongs_to :product

  validates_presence_of :notes
end
