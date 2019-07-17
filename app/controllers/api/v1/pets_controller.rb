class Api::V1::PetsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    data_format = UserPetsFacade.new(user)
    render json: UserPetsSerializer.new(user), status: 200
  end
end
