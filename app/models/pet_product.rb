class PetProduct < ApplicationRecord
  belongs_to :pet
  belongs_to :product
end
