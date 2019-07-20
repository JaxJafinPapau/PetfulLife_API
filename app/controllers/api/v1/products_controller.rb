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

    def index
        begin
            user = User.find(params['user_id'].to_i)
        rescue
            user = nil
        end
        if user
            begin
                products = user.products
            rescue
                products = nil
            end
            if products && products[0]
                userproducts = UserProductsFacade.new(user, products)
                serialized_userproducts = UserProductsSerializer.new(userproducts)
                render json: serialized_userproducts, status: 200
            else
                # Not sure if 203 is the correct response for this, will check.
                render :json => { :error => "This user has no products yet." }, status: 203
            end
        else
            render :json => { :error => "User not found." }, status: 404
        end
    end

    def destroy
        begin
            product = Product.find(params[:id])
        rescue
            product = nil
        end
        if product
            product.delete
            render json: {}, status: 204
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