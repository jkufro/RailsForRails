class ParkPassesController < ApplicationController
  def index
    if is_admin?
      @park_passes = ParkPass.all
    else
      @park_passes = current_user.park_passes.non_expired
    end
    render json: @park_passes
  end
end
