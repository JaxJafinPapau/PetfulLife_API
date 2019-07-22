class Api::V1::PetProductsController < ApplicationController
    def show
        facade = PetProductFacade.new(params)
        result = PetProductSerializer.new(facade)
        render json: result, status: 200
    end

    private

        def create_result(facade)
            return { error: "Sorry, that product wasn't found." } if facade.product == nil
        end
end