class PetProductSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :user_id, :pet_id, :product
end