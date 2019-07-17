require 'rails_helper'

describe 'POST /api/v1/products' do
    it 'creates a new product with a good request' do
        test_product_upc = { upc: 888641131105 }.to_json

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/products", headers: headers, params: test_product_upc

        expect(response.status).to eq(201)

        raw_response = JSON.parse(response.body)

        expect(raw_response).to be_a(Hash)
        expect(raw_response["data"]["attributes"]["id"]).to be_a(Integer)
        expect(raw_response["data"]["attributes"]["upc"]).to eq(888641131105)
        expect(raw_response["data"]["attributes"]["name"]).to be_a(String)
        expect(raw_response["data"]["attributes"]["avg_price"]).to be_a(Float)
    end
end