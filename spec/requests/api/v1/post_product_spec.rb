require 'rails_helper'

describe 'POST /api/v1/products' do
    it 'creates a new product with a good request' do
        test_product_upc = { upc: 9780134657677 }.to_json

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/products", headers: headers, params: test_product_upc

        expect(response.status).to eq(201)

        raw_response = JSON.parse(response.body)

        expect(raw_response).to be_a(Hash)
    end
end