class RideSerializer < ActiveModel::Serializer
  attributes :id, :ride_name, :carts_on_track, :ride_duration, :ride_description, :min_height, :cart_occupancy, :max_allowed_queue_code, :allow_queue, :active, :num_ready_queues, :num_unready_queues, :expected_wait_time

  def num_ready_queues
    object.ready_queues.length
  end

  def num_unready_queues
    object.unready_queues.length
  end

  def expected_wait_time
    object.expected_wait_time
  end
end
