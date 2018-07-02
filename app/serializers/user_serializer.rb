class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :phone, :role, :active, :park_passes

  def park_passes
    object.park_passes.map do |p_pass|
      UserParkPassSerializer.new(p_pass)
    end
  end
end
