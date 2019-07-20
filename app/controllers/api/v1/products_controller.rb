class Api::V1::ProductsController < ApplicationController
    def create
        product = ProductFacade.new(create_params)
        status = create_201_status(product)
        result = create_result(product)
        render status: status, json: result
    end

    def show
        begin
            product = Product.find(params[:id])
        rescue
            product = nil
        end
        if product
            render json: ProductSerializer.new(product), status: 200
        else
            render :json => { :error => "Sorry, that product wasn't found." }, status: 404
        end
    end

    private

        def create_params
            params.permit(:upc).require(:upc)
        end

        def create_201_status(product)
            return 400 if product.id == nil
            return 201 if product.id != nil
        end

        def create_result(product)
            return ProductSerializer.new(product) if product.id != nil
            return {error: "Sorry, that product wasn't found."} if product.id == nil
        end
end