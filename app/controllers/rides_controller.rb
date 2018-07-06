class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :update, :destroy, :call_queue, :reset_queue, :clear_queue]

  def index
    @rides = Ride.all.alphabetical
    @rides = @rides.allow_queue unless is_admin?
    render json: @rides
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

  def reset_queue
    @ride.max_allowed_queue_code = "AAAA"
    if @ride.save
      render json: { message: "Ride Queue Reset" }, status: :ok
    else
      render json: { message: "Could Not Reset Ride Queue", errors: @ride.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def clear_queue
    if @ride.quueues.today.are_not_checked_in.destroy_all
      render json: { message: "Ride Queue Cleared" }, status: :ok
    else
      render json: { message: "Could Not Clear Ride Queue", errors: @ride.errors.full_messages }, status: :unprocessable_entity
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
      params.require(:ride).permit(:ride_name, :carts_on_track, :ride_duration, :ride_description, :min_height, :cart_occupancy, :max_allowed_queue_code, :allow_queue, :active)
    end
end
