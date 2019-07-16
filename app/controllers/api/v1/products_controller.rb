class Api::V1::ProductsController < ApplicationController
    def create
        render status: 201, json: ProductSerializer.new
    end
end