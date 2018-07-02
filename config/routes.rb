Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # sessions controller
  post 'login' => 'sessions#create', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  # home controller
  get 'index' => 'home#index', :as => :home
  get 'login_page' => 'home#login', :as => :login_page
  root 'home#index'

  # users controller
  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'
  post 'users/create' => 'users#create'
  patch 'users/udpate/:id' => 'users#update'
  put 'users/udpate/:id' => 'users#update'
  delete 'users/:id' => 'users#destroy'

  # rides controller
  get 'rides/index' => 'rides#index'
  get 'rides/:id' => 'rides#show'
  post 'rides/create' => 'rides#create'
  patch 'rides/udpate/:id' => 'rides#update'
  put 'rides/udpate/:id' => 'rides#update'
  delete 'rides/:id' => 'rides#destroy'
  get 'rides/:id/call/:num_guests_to_call' => 'rides#call_queue'
end
