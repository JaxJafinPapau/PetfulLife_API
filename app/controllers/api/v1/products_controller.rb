class Api::V1::ProductsController < ApplicationController
    def create
        response_body = ProductFacade.new(create_params)
        render status: 201, json: ProductSerializer.new(response_body)
    end

    private

        def create_params
            params.permit(:upc).require(:upc)
        end
end