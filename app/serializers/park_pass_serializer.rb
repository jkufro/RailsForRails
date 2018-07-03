class ParkPassSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :last_name, :card_number, :card_expiration, :height, :pass_type, :at_park, :current_queue

  def at_park
    object.at_park?
  end

  def current_queue
    cur_queue = object.current_queue
    return QuueueSerializer.new(cur_queue) unless cur_queue.nil?
  end

  def visits
    object.visits.map do |v|
      ParkPassVisitsSerializer.new(v)
    end
  end

  def pass_type
    PassTypeSerializer.new(object.pass_type)
  end
end
