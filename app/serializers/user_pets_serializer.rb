class UserPetsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :pets
end
