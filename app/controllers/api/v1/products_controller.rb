class Api::V1::ProductsController < ApplicationController
    def create
        product = ProductFacade.new(create_params)
        render status: 201, json: ProductSerializer.new(product)
    end

    private

        def create_params
            params.permit(:upc).require(:upc)
        end
end