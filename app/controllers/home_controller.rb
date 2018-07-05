class HomeController < ApplicationController
  def index
    unless logged_in?
      redirect_to :login_page
      return
    end
    if is_admin?
      render 'admin_area'
      return
    else
      render 'index'
      return
    end
  end

  def login
    if logged_in?
      redirect_to :home
    end
  end
end
