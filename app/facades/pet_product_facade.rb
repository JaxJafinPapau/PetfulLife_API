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
        pp = PetProduct.includes(:product).where(product_id: @id, pet_id: @pet_id).first
        {
          id: pp.product.id,
          name: pp.product.name,
          avg_price: pp.product.avg_price,
          upc: pp.product.upc,
          good_or_bad: pp.good_or_bad,
          notes: pp.notes
        }
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
