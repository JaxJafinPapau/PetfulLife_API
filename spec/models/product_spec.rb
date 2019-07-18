require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_numericality_of(:avg_price)}
    it {should validate_numericality_of(:upc)}
  end

  describe 'relationships' do
    it {should have_many(:users).through(:user_products)}
    it {should have_many(:pets).through(:pet_products)}
  end
end
