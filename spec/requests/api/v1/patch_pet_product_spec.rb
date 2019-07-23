require 'rails_helper'

describe 'PATCH /api/v1/users/:user_id/pets/:pet_id/products/:product_id' do
    before :each do
        @user = User.create!(username: "test_user", email: "testingwtf@test.com", password_digest: "asdf")
        @pet = @user.pets.create!(name: "Trevor", nickname: "Pupper", archetype: "Dog", breed: "Labradoodle")
        @product_1 = @user.products.create!(name: "test_product", upc: 330033003300, avg_price: 1.23)
        @product_2 = @user.products.create!(name: "2008, A Britney Oddity", upc: 220022002200, avg_price: 2.34)
        @pet.products << @product_1
        @headers = { "CONTENT_TYPE" => "application/json" }
    end
    it 'should update the good_or_bad to good without notes' do
        body = { good_or_bad: "good" }.to_json

        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id}/products/#{@product_1.id}", headers: @headers, params: body
        expect(response.status).to eq(202)
    end

    it 'should update the good_or_bad and notes with both' do
        body = { good_or_bad: "bad", notes: "Gave Trevor the squishy poops." }.to_json
        
        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id}/products/#{@product_1.id}", headers: @headers, params: body

        expect(response.status).to eq(202)
    end

    #sad path
    it 'should not update without good_or_bad' do
        body = { notes: "Gave Trevor the squishy poops."}.to_json

        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id}/products/#{@product_1.id}", headers: @headers, params: body

        error = JSON.parse(response.body)
        expect(response.status).to eq(400)
        expect(error['error']).to eq("You must pass either good or bad as a single string.")
    end
    it 'should not update with an invalid value for good_or_bad' do
        body = { good_or_bad: "fluff", notes: "Gave Trevor the squishy poops."}.to_json

        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id}/products/#{@product_1.id}", headers: @headers, params: body

        error = JSON.parse(response.body)
        expect(response.status).to eq(400)
        expect(error['error']).to eq("You must pass either good or bad as a single string.")
    end
    # it 'should not update if the user does not exist' do
    #  add this test when authentication is implimented
    # end
    it 'should not update if the pet does not exist' do
        body = { good_or_bad: "bad", notes: "Gave Trevor the squishy poops."}.to_json

        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id + 2008}/products/#{@product_1.id}", headers: @headers, params: body

        error = JSON.parse(response.body)
        expect(response.status).to eq(404)
        expect(error['error']).to eq("Pet not found.")
    end
    it 'should not update if the product does not exist' do
        body = { good_or_bad: "bad", notes: "Gave Trevor the squishy poops."}.to_json

        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id}/products/#{@product_1.id + 2008}", headers: @headers, params: body

        error = JSON.parse(response.body)
        expect(response.status).to eq(404)
        expect(error['error']).to eq("Product not found.")
    end
    it 'should not update if the product is not associated with the pet' do
        body = { good_or_bad: "bad", notes: "Gave Trevor the squishy poops."}.to_json

        patch "/api/v1/users/#{@user.id}/pets/#{@pet.id}/products/#{@product_2.id}", headers: @headers, params: body

        error = JSON.parse(response.body)
        expect(response.status).to eq(404)
        expect(error['error']).to eq("Product does not belong to that pet, please make a post request first.")
    end
end