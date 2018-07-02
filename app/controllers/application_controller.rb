class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  # just show a flash message instead of full CanCan exception
  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "You are not authorized to perform this action."
  #   redirect_to home_path
  # end

  # handle 404 errors with an exception as well
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to :home
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def is_admin?
    logged_in? && current_user.role?(:admin)
  end

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end
end
