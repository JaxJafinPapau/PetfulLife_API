class PetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :nickname, :breed, :archetype
end
