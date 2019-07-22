require 'rails_helper'

describe 'GET /api/v1/users/:user_id/pets/:pet_id/product/:product_id' do
    it 'should return the product associated with the pet' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = pet.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/pets/#{pet.id}/products/#{product_1.id}/", headers: headers

        expect(response.status).to eq(200)

        pet_product = JSON.parse(response.body)['data']['attributes']
        expect(pet_product['product']['id']).to eq(product_1.id)
        expect(pet_product['product']['name']).to eq(product_1.name)
        expect(pet_product['product']['upc']).to eq(product_1.upc)
        expect(pet_product['product']['avg_price']).to eq(product_1.avg_price)
    end
end