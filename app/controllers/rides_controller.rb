class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :update, :destroy, :call_queue]

  def index
    render json: Ride.all.alphabetical
  end

  def show
    render json: @ride
  end

  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      render json: { message: "Ride Created" }, status: :ok
    else
      render json: { message: "Could Not Create Ride", errors: @ride.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @ride.update(ride_params)
    if @ride.save
      render json: { message: "Ride Updated" }, status: :ok
    else
      render json: { message: "Could Not Update Ride", errors: @ride.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @ride.destroy
      render json: { message: "Ride Removed" }, status: :ok
    else
      render json: { message: "Could Not Remove Ride", errors: @ride.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def call_queue
    num_call = params[:num_guests_to_call]
    if @ride.call_queue(num_call.to_i)
      render json: { message: "#{num_call} Guests Called" }, status: :ok
    else
      render json: { message: "Could Increase Queue", errors: @ride.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def set_ride
      @ride = Ride.find(params[:id])
    end

    def ride_params
      params.require(:ride).permit(:carts_on_track, :ride_duration, :ride_description, :min_height, :cart_occupancy, :max_allowed_queue_code, :allow_queue, :active)
    end
end