require 'rails_helper'

describe 'When I visit /users' do
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
