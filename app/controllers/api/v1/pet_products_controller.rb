class Api::V1::PetProductsController < ApplicationController
    def show
      facade = PetProductFacade.new(params)
      if facade.user && facade.user.pets.include?(facade.pet) && facade.pet.products.include?(facade.product)
        render json: PetProductSerializer.new(facade), status: 200
      elsif facade.user == nil
        render :json => { :error => "User not found" }, status: 404
      elsif facade.pet == nil || facade.user.pets.exclude?(facade.pet)
        render :json => { :error => "Pet not found" }, status: 404
      elsif facade.product == nil || facade.pet.product.exclude?(facade.product)
        render :json => { :error => "Product not found" }, status: 404
      else
        render :json => { :error => "Bad Request" }, status: 400
      end
    end

    def create
      pet = Pet.find(params[:pet_id])
      product = Product.find(params[:id])
      pet.products << product
    end
end
