class UserPetsFacade
  attr_reader :id, :username
  def initialize(user, pet = nil)
    @id = user.id
    @username = user.username
    @pet_data = user.pets
    @pet_id = pet
  end

  def pets
    unless @pet_id
      @pet_data.map do |pet|
        UserPet.new(pet)
      end
    else
      pet = @pet_data.where(id: @pet_id)
      UserPet.new(pet.first)
    end
  end
end
