require 'rails_helper'

describe 'GET /api/v1/users/:user_id/pets/:pet_id/products' do
    it 'should return a pet and their associated products but not others' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = pet.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/pets/#{pet.id}/products", headers: headers

        expect(response.status).to eq(200)

        pet_with_products = JSON.parse(response.body)['data']['attributes']
        expect(pet_with_products['id']).to eq(pet.id)
        expect(pet_with_products['products']).to be_a(Array)
        expect(pet_with_products['products'][0]['name']).to eq(product_1.name)
        expect(pet_with_products['products'][0]['upc']).to eq(product_1.upc)
        expect(pet_with_products['products'][0]['avg_price']).to eq(product_1.avg_price)

        product_ids = pet.products map { |p| p.id }
        expect(product_ids).to_not have_value(product_2)
    end
end