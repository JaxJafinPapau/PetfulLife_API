class UserPetsFacade
  attr_reader :id
  def initialize(user)
    @id = user.id
    @username = user.username
    @pets = user.pets
  end

  def pets(id = nil)
    unless id
      @pets.map do |pet|
        UserPet.new(pet)
      end
    else
      pet = @pet.where(id: id)
      UserPet.new(pet)
    end
  end
end
