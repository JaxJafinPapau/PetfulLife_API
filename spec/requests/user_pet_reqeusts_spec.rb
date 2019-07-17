require 'rails_helper'

describe 'when I visit /users/:id/pets' do
  describe 'getting users pets' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
    end
    it "displays a user and a user's pets" do
      pet_1 = @user.pets.create(name: "Chocolate", archetype: 'dog', breed: 'mutt', nickname: 'Choco')
      pet_2 = @user.pets.create(name: "Vanilla", archetype: 'dog', breed: 'mutt', nickname: 'Van')
      get "/api/v1/users/#{@user.id}/pets"

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data['data']['id'].to_i).to eq(@user.id)
      expect(data['data']['attributes']['pets'].count).to eq(2)
      expect(data['data']['attributes']['pets'].first['id'].to_i).to eq(pet_1.id)
      expect(data['data']['attributes']['pets'].last['id'].to_i).to eq(pet_2.id)
    end
  end
end
