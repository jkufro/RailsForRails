class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  load_and_authorize_resource

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "User Created" }, status: :ok
    else
      render json: { message: "Could Not Create User", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      render json: { message: "User Updated" }, status: :ok
    else
      render json: { message: "Could Not Update User", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: "User Removed" }, status: :ok
    else
      render json: { message: "Could Not Remove User", errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :phone, :active, :role, :password, :password_confirmation)
    end

    def new_password_params
      params.require(:password_reset).permit(:old_password, :new_password, :new_password_confirmation)
    end
end
