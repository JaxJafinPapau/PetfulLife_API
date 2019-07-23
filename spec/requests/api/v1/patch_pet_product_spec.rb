require 'rails_helper'

describe 'PATCH /api/v1/users/:user_id/pets/:pet_id/products/:product_id' do
    it 'should update the good_or_bad to good without notes' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        pet = user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        product_1 = user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        pet.products << product_1

        headers = { "CONTENT_TYPE" => "application/json" }
        body = { good_or_bad: "good" }.to_json

        patch "/api/v1/users/#{user.id}/pets/#{pet.id}/products/#{product_1.id}", headers: headers, params: body

        expect(response.status).to eq(202)

    end
end