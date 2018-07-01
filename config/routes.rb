Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'login' => 'sessions#create', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'index' => 'home#index', :as => :home
  get 'login_page' => 'home#login', :as => :login_page
end
