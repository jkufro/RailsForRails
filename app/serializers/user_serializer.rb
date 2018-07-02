class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :phone, :role, :active
end
