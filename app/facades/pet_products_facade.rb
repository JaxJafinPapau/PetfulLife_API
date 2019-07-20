class PetProductsFacade
    attr_reader :products
    def initialize(pet, products)
        @pet = pet
        @products = products
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