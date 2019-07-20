class UserProductsSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :username, :products
end