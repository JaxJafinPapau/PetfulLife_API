require 'rails_helper'

RSpec.describe UserProduct, type: :model do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:product)}
    it {should validate_numericality_of(:rating)}
  end
end
