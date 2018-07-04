class QuueueController < ApplicationController
  before_action :set_quueue, only: [:cancel]

  def create
    ride_id = params['ride_id'].to_i
    visit_id = Visit.find_by_park_pass_id(params['park_pass_id']).id
    @quueue = Quueue.new({ride_id: ride_id, visit_id: visit_id})
    if @quueue.save
      render json: { message: "Queue Created" }, status: :ok
    else
      render json: { message: "Could Not Create Queue", errors: @quueue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def cancel
    if @quueue.delete
      render json: { message: "Queue Cancelled" }, status: :ok
    else
      render json: { message: "Could Not Cancel Queue", errors: @quueue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def set_quueue
    @quueue = Quueue.find(params[:id])
  end
end
