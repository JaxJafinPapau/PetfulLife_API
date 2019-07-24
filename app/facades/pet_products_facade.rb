class PetProductsFacade
    def initialize(pet)
        @pet = pet
        @pet_products = pet.pet_products
    end

    def products
        @pet_products.map do |pp|
            { id: pp.product.id,
              name: pp.product.name,
              avg_price: pp.product.avg_price,
              upc: pp.product.upc,
              good_or_bad: pp.good_or_bad,
              notes: pp.notes
             }
        end
    end

    def id
        @pet.id
    end
    def name
        @pet.name
    end
    def nickname
        @pet.nickname
    end
    def archetype
        @pet.archetype
    end
    def breed
        @pet.breed
    end
end