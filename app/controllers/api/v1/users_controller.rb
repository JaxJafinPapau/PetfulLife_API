class Api::V1::UsersController < ApplicationController

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

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
