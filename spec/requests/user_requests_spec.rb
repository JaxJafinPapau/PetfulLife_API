require 'rails_helper'

describe 'When I visit /users' do
  describe 'getting a user' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
    end

    it 'will get a user when a valid id is passed' do
      get "/api/v1/users/#{@user.id}"

      data = JSON.parse(response.body)
      user = User.last

      expect(response.code).to eq('200')
      expect(data['data']['id'].to_i).to eq(user.id)
      expect(data['data']['type']).to eq('user')
      expect(data['data']['attributes']).to include('id', 'username')
    end

    it 'will fail when no user is present' do

      get "/api/v1/users/#{@user.id + 1}"

      data = JSON.parse(response.body)

      expect(response.code).to eq('404')
      expect(data['error']).to eq('User not found')
    end
  end

  describe 'user creation' do
    it 'creates a user' do
      post '/api/v1/users', params: {
        "username": "steve",
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      data = JSON.parse(response.body)

      user = User.last

      expect(response.code).to eq('201')
      expect(data['data']).to_not be_nil
      expect(data['data']['id'].to_i).to eq(user.id)
      expect(user.email).to eq("whatever@example.com")
      expect(user.username).to eq("steve")


    end

    it 'returns an error if incorrect' do
      post '/api/v1/users', params: {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "paword"
      }

      data = JSON.parse(response.body)

      expect(response.code).to eq('400')
      expect(data['errors'].first).to eq("Password confirmation doesn't match Password")
      expect(data['errors'].last).to eq("Username can't be blank")
    end
  end

  describe 'Updating a user' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
    end
    it 'updates a user password' do
      patch "/api/v1/users/#{@user.id}", params: {
        "password": "andrew",
        "password_confirmation": "andrew"
      }
      data = JSON.parse(response.body)
      user = User.last

      expect(response.code).to eq('201')
      expect(data['data']).to_not be_nil
      expect(data['data']['id'].to_i).to eq(user.id)
      expect(@user.password_digest).to_not eq(user.password_digest)
    end

    it 'updates a user username without password' do
      patch "/api/v1/users/#{@user.id}", params: {
        "username": "andrew",
        "email": "email@email.com"
      }
      data = JSON.parse(response.body)
      user = User.last


      expect(response.code).to eq('201')
      expect(data['data']).to_not be_nil
      expect(data['data']['id'].to_i).to eq(user.id)
      expect(@user.username).to_not eq(user.username)
      expect(@user.email).to_not eq(user.email)
    end

    it 'fail with errors if no params or wrongs params are sent' do
      patch "/api/v1/users/#{@user.id}"
      data = JSON.parse(response.body)

      expect(response.code).to eq('400')

      patch "/api/v1/users/#{@user.id}", params: {
        'pancakes': 'pancakes'
      }
      data = JSON.parse(response.body)

      expect(response.code).to eq('400')

    end
  end

  describe 'deleting a user' do
    before :each do
      @user = User.create(username: "bob", email: "bob@bob.com", password: "bobby")
    end

    it 'should delete a user' do
      delete "/api/v1/users/#{@user.id}"

      expect(response.code).to eq('202')
      expect(User.last).to be_nil
    end

    it 'should delete a user' do
      delete "/api/v1/users/#{@user.id + 1}"

      expect(response.code).to eq('404')
      expect(User.last).to_not be_nil
    end
  end
end
