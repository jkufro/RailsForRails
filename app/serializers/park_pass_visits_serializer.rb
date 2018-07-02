class ParkPassVisitsSerializer < ActiveModel::Serializer
  attributes :id, :visit_date, :current_queue, :ridden_rides_summary

  def current_queue
    object.current_queue
  end

  def ridden_rides_summary
    object.ridden_rides_summary
  end
end
