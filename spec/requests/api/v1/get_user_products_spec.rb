require 'rails_helper'

describe 'GET api/v1/users/:user_id/products' do
    it 'should return the user and their associated products' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        product_1 = user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        product_2 = user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/products", headers: headers

        expect(response.status).to eq(200)

        user_with_products = JSON.parse(response.body)['data']['attributes']
        expect(user_with_products['id']).to eq(user.id)
        expect(user_with_products['products']).to be_a(Array)
        expect(user_with_products['products'][0]['name']).to eq(product_1.name)
        expect(user_with_products['products'][0]['upc']).to eq(product_1.upc)
        expect(user_with_products['products'][0]['avg_price']).to eq(product_1.avg_price)
        expect(user_with_products['products'][1]['name']).to eq(product_2.name)
    end

    # sad path
    it 'should return no products found error message if the user has no products' do
        user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/#{user.id}/products", headers: headers

        expect(response.status).to eq(206)

        user_no_ps_error = JSON.parse(response.body)
        expect(user_no_ps_error['error']).to eq("This user has no products yet.")
    end

    it 'should return user not found error message if the user cannot be found' do
        user = User.create!(id: 2001, username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")

        headers = { "CONTENT_TYPE" => "application/json" }

        get "/api/v1/users/1999/products", headers: headers

        expect(response.status).to eq(404)

        user_no_ps_error = JSON.parse(response.body)
        expect(user_no_ps_error['error']).to eq("User not found.")
    end
end