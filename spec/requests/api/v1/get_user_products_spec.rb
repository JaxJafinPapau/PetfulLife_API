require 'rails_helper'

describe 'GET api/v1/users/:user_id/products' do
    it 'should return the user and their associated products' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        product_1 = user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/products", headers: headers

        expect(response.status).to eq(200)

        # response_product = JSON.parse(response.body)['data']['attributes']
        # expect(response_product['id']).to eq(product_1.id)
        # expect(response_product['name']).to eq(product_1.name)
        # expect(response_product['upc']).to eq(product_1.upc)
        # expect(response_product['avg_price']).to eq(product_1.avg_price)
    end
end