class Api::V1::UsersController < ApplicationController

  def show
    begin
      user = User.find(params[:id])
    rescue
      user = nil
    end
    if user
      render json: UserSerializer.new(user), status: 200
    else
      render :json => { :error => "User not found" }, status: 404
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render :json => { :errors => user.errors.full_messages }, status: 400
    end
  end

  def update
    user = User.find(params[:id])
    if user && user_params.present?
      user.update(user_params)
      render json: UserSerializer.new(user), status: 201
    else
      render :json => { :errors => user.errors.full_messages }, status: 400
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
    rescue
      user = nil
    end
    if user
      user.delete
      render json: {}, status: 204
    else
      render :json => { :error => "User not found" }, status: 404
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
