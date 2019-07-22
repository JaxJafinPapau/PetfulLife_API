class Api::V1::PetsController < ApplicationController
  def index
    user = user_exist?(params[:user_id])
    if user
      data_format = UserPetsFacade.new(user)
      render json: UserPetsSerializer.new(data_format), status: 200
    else
      render :json => { :error => "User not found" }, status: 404
    end
  end

  def show
    user = user_exist?(params[:user_id])
    pet = pet_exist?(params[:id])
    if user && user.pets.include?(pet)
      data_format = UserPetsFacade.new(user, pet)
      render json: UserPetsSerializer.new(data_format), status: 200
    elsif user == nil && pet == nil
      render :json => { :error => "Invalid Request" }, status: 400
    elsif user == nil
      render :json => { :error => "User not found" }, status: 404
    elsif user.pets.exclude?(pet)
      render :json => { :error => "Pet not found" }, status: 404
    end
  end

  def create
    user = user_exist?(params[:user_id])
    if user
      pet = user.pets.create(pet_params)
      if pet.save
        render json: PetSerializer.new(pet), status: 201
      else
        render :json => { :errors => pet.errors.full_messages }, status: 400
      end
    else
      render :json => { :error => 'User not Found' }, status: 400
    end
  end

  def update
    user = user_exist?(params[:user_id])
    pet = pet_exist?(params[:id])
    if user && user.pets.include?(pet) && pet_params.present?
      pet.update(pet_params)
      render json: PetSerializer.new(pet), status: 202
    else
      render :json => { :error => "Bad Request" }, status: 400
    end
  end

  def destroy
    user = user_exist?(params[:user_id])
    pet = pet_exist?(params[:id])
    if user && user.pets.include?(pet)
      pet.destroy
      render :json => {}, status: 204
    else
      render :json => { :error => "Bad Request" }, status: 400
    end
  end

  private

  def pet_params
    params.permit(:name, :nickname, :archetype, :breed)
  end

  def pet_exist?(id)
    begin
      Pet.find(id)
    rescue
      nil
    end
  end
end
