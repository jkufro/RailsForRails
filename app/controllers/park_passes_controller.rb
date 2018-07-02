class ParkPassesController < ApplicationController
  def index
    if is_admin?
      @passes = ParkPasses.all
    else
      @passes = current_user.park_passes.non_expired
    end
    render json: @passes
  end
end
