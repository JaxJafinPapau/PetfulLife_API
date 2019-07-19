require 'rails_helper'

describe 'DELETE /api/v1/products/:id' do
    it 'should delete a product when the product exists' do
        product_1 = Product.create(name: "test_product", upc: 330033003300, avg_price: 1.23)

        headers = { "CONTENT_TYPE" => "application/json" }

        delete "/api/v1/products/#{product_1.id}", headers: headers

        expect(response.status).to eq(204)

        product_ids = Product.all.map { |p| p.id }
        expect(product_ids).to_not include(product_1.id)
    end
end