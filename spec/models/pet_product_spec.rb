require 'rails_helper'

RSpec.describe PetProduct, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:notes)}
    it {should allow_value(nil).for(:good_or_bad)}
  end

  describe 'relationships' do
    it {should belong_to(:pet)}
    it {should belong_to(:product)}
  end
end
