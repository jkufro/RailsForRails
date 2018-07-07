class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    if is_admin?
      @users = User.all.alphabetical
    else
      @users = [current_user]
    end
    render json: @users
  end

  def show
    render json: @user
  end

  def show_by_username
    @user = User.find_by_username(params[:username])
    if @user.nil?
      render json: { message: "Could Not Find User", errors: [] }, status: :unprocessable_entity
      return
    end

    render json: @user
  end

  def create
    pms = user_params
    unless is_admin?
      pms[:role] = 'visitor'
    end
    @user = User.new(pms)
    if @user.save
      session[:user_id] = @user.id unless is_admin?
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

  def usernames
    ready_codes = User.all.alphabetical.select("username")
    json_usernames = Hash.new()
    ready_codes.each do |user|
      json_usernames[user.username] = nil
    end
    render json: json_usernames, status: :ok
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :phone, :role, :password, :password_confirmation)
    end

    def new_password_params
      params.require(:password_reset).permit(:old_password, :new_password, :new_password_confirmation)
    end
end
