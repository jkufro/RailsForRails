class QuueueController < ApplicationController
  before_action :set_quueue, only: [:cancel]

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
