class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    req = login_params
    un = login_params[:username]
    pw = login_params[:password]

    # allow the username field to be either a username or email address
    user = User.find_by_email(un)
    user ||= User.find_by_username(un)

    # if auth success
    if user && (User.authenticate_username(un, pw) || User.authenticate_email(un, pw))
        session[:user_id] = user.id
        render json: { message: "Logged In" }, status: :ok
      else
        render json: { message: "Invalid Credentials" }, status: :unprocessable_entity
      end

  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Logged Out" }, status: :ok
  end

  private
  def login_params
    params.require(:login_form).permit(:username, :password)f
  end
end
