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
      pet = pet_exist?(params[:pet_id])
      product = product_exist?(params[:id])
      user = user_exist?(params[:user_id])
      if user && pet && product
        pet.products << product
        render status: 204
      elsif user == nil
        render status: 404, json: { error: "User not found." }
      elsif pet == nil
        render status: 404, json: { error: "Pet not found." }
      elsif product == nil
        render status: 404, json: { error: "Product not found." }
      else
        render status: 400, json: { error: "Bad request." }
      end
    end
end
