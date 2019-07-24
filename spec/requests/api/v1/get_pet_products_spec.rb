require 'rails_helper'

describe 'GET /api/v1/users/:user_id/pets/:pet_id/products' do
    it 'should return a pet and their associated products but not others' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = pet.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        patch "/api/v1/users/#{user.id}/pets/#{pet.id}/products/#{product_1.id}", headers: headers, params: { good_or_bad: "bad", notes: "yeehaw"}.to_json
        get "/api/v1/users/#{user.id}/pets/#{pet.id}/products", headers: headers

        expect(response.status).to eq(200)

        pet_with_products = JSON.parse(response.body)['data']['attributes']
        expect(pet_with_products['id']).to eq(pet.id)
        expect(pet_with_products['products']).to be_a(Array)
        expect(pet_with_products['products'][0]['name']).to eq(product_1.name)
        expect(pet_with_products['products'][0]['upc']).to eq(product_1.upc)
        expect(pet_with_products['products'][0]['avg_price']).to eq(product_1.avg_price)
        binding.pry
        expect(pet_with_products['products'][0]['good_or_bad']).to eq(false)

        product_ids = pet.products.map { |p| p.id }
        expect(product_ids).not_to include(product_2.id)
    end

    # sad path
    it 'should give appropriate error message if a pet has no products' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/pets/#{pet.id}/products", headers: headers

        expect(response.status).to eq(206)
        error = JSON.parse(response.body)['error']

        expect(error).to eq("This pet has no associated products.")
    end

    it 'should give appropriate error message if a pet is not found' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(id: 23, name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/pets/2004/products", headers: headers

        expect(response.status).to eq(404)
        error = JSON.parse(response.body)['error']

        expect(error).to eq("Pet not found.")
    end
end