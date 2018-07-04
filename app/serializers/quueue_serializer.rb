class QuueueSerializer < ActiveModel::Serializer
  attributes :id, :visit_id, :queue_code, :security_code, :checked_in, :expected_wait, :ride_name, :is_ready

  def expected_wait
    return [object.ride.expected_wait_time(object.queue_code), 0].max
  end

  def ride_name
    object.ride.ride_name
  end

  def is_ready
    object.is_ready?
  end
end
