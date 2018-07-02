class UserParkPassSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :last_name, :card_number, :card_expiration, :height, :visits, :pass_type

  def visits
    object.visits.map do |v|
      ParkPassVisitsSerializer.new(v)
    end
  end

  def pass_type
    PassTypeSerializer.new(object.pass_type)
  end
end
