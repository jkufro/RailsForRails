class ParkPassesController < ApplicationController
  def index
    if is_admin?
      @park_passes = ParkPass.all
    else
      @park_passes = current_user.park_passes.non_expired
    end
    render json: @park_passes
  end

  def create
    @park_pass = ParkPass.new(park_pass_params)
    @park_pass.pass_type_id
    if @park_pass.save
      render json: { message: "Park Pass Created" }, status: :ok
    else
      render json: { message: "Could Not Create Park Pass", errors: @park_pass.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def park_pass_params
    params.require(:park_pass).permit(:user_id, :pass_type_id, :first_name, :last_name, :card_number, :height)
  end
end
