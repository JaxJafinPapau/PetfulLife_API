class Api::V1::ProductsController < ApplicationController
    def create
        product = ProductFacade.new(create_params)
        status = create_status(product)
        result = create_result(product)
        render status: status, json: result
    end

    private

        def create_params
            params.permit(:upc).require(:upc)
        end

        def create_status(product)
            return 400 if product.id == nil
            return 201 if product.id != nil
        end

        def create_result(product)
            return ProductSerializer.new(product) if product.id != nil
            return {error: "Sorry, that product wasn't found."} if product.id == nil
        end
end