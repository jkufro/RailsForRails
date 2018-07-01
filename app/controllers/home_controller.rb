class HomeController < ApplicationController
  def index
    unless logged_in?
      redirect_to :login_page
    end
  end

  def login
    if logged_in?
      redirect_to :home
    end
  end
end
