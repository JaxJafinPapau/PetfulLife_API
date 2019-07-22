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
      begin
        Product.find(@id)
      rescue
        nil
      end
    end

    def pet
      begin
        Pet.find(@pet_id)
      rescue
        nil
      end
    end

    def user
      begin
        User.find(@user_id)
      rescue
        nil
      end
    end
end
