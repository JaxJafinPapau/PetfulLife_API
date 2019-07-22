class PetProductFacade
    attr_reader :user_id,
                :pet_id,
                :id

    def initialize(params)
        @user_id = params['user_id']
        @pet_id = params['pet_id']
        @id = params['id']
    end

    def product
        p = Product.find(@id)
        return p if p
        nil
    end

    def pet
        p = Pet.find(@pet_id)
        return p if p
        nil
    end

    def user
        u = User.find(@user_id)
        return u if u
        nil
    end
end