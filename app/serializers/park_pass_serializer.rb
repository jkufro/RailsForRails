class ParkPassSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :last_name, :card_number, :card_expiration, :height, :pass_type, :at_park, :current_queue

  def at_park
    object.at_park?
  end

  def current_queue
    todays_visit = object.visits.today
    unless todays_visit == []
        todays_visit = todays_visit.first
        cur_queue = todays_visit.current_queue
        return cur_queue
    end
    return nil
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
