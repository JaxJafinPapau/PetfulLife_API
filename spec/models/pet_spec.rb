require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:archetype)}
    it {should validate_presence_of(:breed)}

  end

  describe 'relationships' do
    it {should belong_to(:user)}
    it {should have_many(:products).through(:pet_products)}
  end
end
