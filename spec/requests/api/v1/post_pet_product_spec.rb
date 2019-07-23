require 'rails_helper'

describe 'POST api/v1/users/:user_id/pets/:pet_id/products/:product_id' do
    it 'associates a product to a pet' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/users/#{user.id}/pets/#{pet.id}/products/#{product_1.id}", headers: headers

        expect(response.status).to eq(204)
        expect(pet.products).to include(product_1)
        expect(pet.products).to_not include(product_2)
    end

    it 'returns proper error message when user not found' do
        user = User.create!(id: 5432, username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/users/234/pets/#{pet.id}/products/#{product_1.id}", headers: headers

        error = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(error['error']).to eq("User not found.")
        expect(pet.products).to_not include(product_1, product_2)
    end
    it 'returns proper error message when pet not found' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(id: 2353, name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/users/#{user.id}/pets/532/products/#{product_1.id}", headers: headers

        error = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(error['error']).to eq("Pet not found.")
        expect(pet.products).to_not include(product_1, product_2)
    end
    it 'returns proper error message when product not found' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = user.products.create!(id: 6324, name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/users/#{user.id}/pets/#{pet.id}/products/2345", headers: headers

        error = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(error['error']).to eq("Product not found.")
        expect(pet.products).to_not include(product_1, product_2)
    end
end