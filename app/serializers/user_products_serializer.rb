class UserProductsSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :username, :email, :products
end