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

    it 'gives a 404 if there is not user' do
      get "/api/v1/users/#{@user.id + 1}/pets"

      data = JSON.parse(response.body)

      expect(data['error']).to eq("User not found")
    end
  end

  describe 'getting a single users pet' do
    before :each do
      @user_1 = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
      @user_2 = User.create(username: "steve", email: "steve@steve.com", password: "stevey")
    end
    it 'displays a user and a single pet' do
      pet_1 = @user_1.pets.create(name: "Chocolate", archetype: 'dog', breed: 'mutt', nickname: 'Choco')
      pet_2 = @user_1.pets.create(name: "Vanilla", archetype: 'dog', breed: 'mutt', nickname: 'Van')
      get "/api/v1/users/#{@user_1.id}/pets/#{pet_1.id}"

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data['data']['id'].to_i).to eq(@user_1.id)
      expect(data['data']['attributes']['pets']['id'].to_i).to eq(pet_1.id)
      expect(data['data']['attributes']['pets']['name']).to eq(pet_1.name)
    end

    it 'will error if information is incorrect' do
      pet_1 = @user_1.pets.create(name: "Chocolate", archetype: 'dog', breed: 'mutt', nickname: 'Choco')
      pet_2 = @user_2.pets.create(name: "Vanilla", archetype: 'dog', breed: 'mutt', nickname: 'Van')

      get "/api/v1/users/#{@user_1.id}/pets/#{pet_1.id + 2}"
      data = JSON.parse(response.body)
      expect(response.code).to eq('404')
      expect(data['error']).to eq('Pet not found')

      get "/api/v1/users/#{@user_1.id + 2}/pets/#{pet_1.id}"
      data = JSON.parse(response.body)
      expect(response.code).to eq('404')
      expect(data['error']).to eq('User not found')

      get "/api/v1/users/#{@user_1.id + 2}/pets/#{pet_1.id + 2}"
      data = JSON.parse(response.body)
      expect(response.code).to eq('400')
      expect(data['error']).to eq('Invalid Request')
    end
  end

  describe 'Pet creation' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
    end

    it 'allows a user to create a pet' do
      post "/api/v1/users/#{@user.id}/pets", params: {
        'name': 'pupper',
        'nickname': 'pup',
        'archetype': 'dog',
        'breed': 'mutt'
      }
      data = JSON.parse(response.body)

      expect(response.code).to eq('201')
      expect(data['data']['type']).to eq('pet')
      expect(data['data']['attributes']['name']).to eq('pupper')
    end

    it 'will give explicit error is something in field is missing' do
      post "/api/v1/users/#{@user.id}/pets", params: {
        'name': 'pupper',
        'nickname': 'pup',
        'breed': 'mutt'
      }
      data = JSON.parse(response.body)

      expect(response.code).to eq('400')
      expect(data['errors']).to eq(["Archetype can't be blank"])
    end

    it 'will give error is user does not exist' do
      post "/api/v1/users/#{@user.id + 1}/pets", params: {
        'name': 'pupper',
        'nickname': 'pup',
        'archetype': 'dog',
        'breed': 'mutt'
      }
      data = JSON.parse(response.body)

      expect(response.code).to eq('400')
      expect(data['error']).to eq("User not Found")
    end
  end

  describe 'update an existing pet' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
    end

    it 'allows a user to up an existing pet' do
      pet = @user.pets.create(name: "Chocolate", archetype: 'dog', breed: 'mutt', nickname: 'Choco')
      patch "/api/v1/users/#{@user.id}/pets/#{pet.id}", params: {
        'name': 'pupper',
        'nickname': 'pup',
        'archetype': 'dog',
        'breed': 'motto'
      }
      updated_pet = Pet.last
      data = JSON.parse(response.body)

      expect(response.code).to eq('202')
      expect(data['data']['type']).to eq('pet')
      expect(data['data']['attributes']['name']).to eq('pupper')
      expect(updated_pet.name).to eq('pupper')
      expect(updated_pet.breed).to eq('motto')
    end

    it 'will error is the user give bad info' do
      pet = @user.pets.create(name: "Chocolate", archetype: 'dog', breed: 'mutt', nickname: 'Choco')
      patch "/api/v1/users/#{@user.id}/pets/#{pet.id + 1}", params: {
        'name': 'pupper',
        'nickname': 'pup',
        'archetype': 'dog',
        'breed': 'motto'
      }

      updated_pet = Pet.last
      data = JSON.parse(response.body)

      expect(response.code).to eq('400')
      expect(data['error']).to eq("Bad Request")
    end
  end

  describe 'pet deletion' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
      @pet = @user.pets.create(name: "Chocolate", archetype: 'dog', breed: 'mutt', nickname: 'Choco')
    end

    it 'will allow a user to delete a pet' do
      delete "/api/v1/users/#{@user.id}/pets/#{@pet.id}"

      expect(response.code).to eq('204')
      expect(@user.pets.count).to eq(0)
    end

    it 'will not delete a pet that does not belong to that owner' do
      user_2 = User.create(username: "Steve", email: "steve@steve.com", password: "stevey")
      pet_2 = user_2.pets.create(name: "Vanilla", archetype: 'dog', breed: 'mutt', nickname: 'Van')

      delete "/api/v1/users/#{@user.id}/pets/#{pet_2.id}"

      data = JSON.parse(response.body)

      expect(response.code).to eq('400')
      expect(data['error']).to eq("Bad Request")
    end
  end
end
