class PetProductsSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :name, :nickname, :archetype, :breed, :products
end