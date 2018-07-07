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
  get 'users/:id/show' => 'users#show'
  get 'users/show_by_username/:username' => 'users#show_by_username'
  get 'users/usernames' => 'users#usernames'
  post 'users/create' => 'users#create'
  patch 'users/:id/update' => 'users#update'
  put 'users/:id/update' => 'users#update'
  delete 'users/:id' => 'users#destroy'

  # rides controller
  get 'rides/index' => 'rides#index'
  get 'rides/:id' => 'rides#show'
  post 'rides/create' => 'rides#create'
  patch 'rides/:id/update' => 'rides#update'
  put 'rides/:id/update' => 'rides#update'
  delete 'rides/:id' => 'rides#destroy'
  get 'rides/:id/call/:num_guests_to_call' => 'rides#call_queue'
  get 'rides/:id/reset_queue' => 'rides#reset_queue'
  get 'rides/:id/clear_queue' => 'rides#clear_queue'
  get 'rides/:id/ready_security_codes' => 'rides#ready_security_codes'
  get 'rides/:id/check_in/:security_code' => 'rides#check_in'

  # park passes controller
  get 'park_passes/index' => 'park_passes#index'

  # quueues controller
  get 'queues/:id/cancel' => 'quueue#cancel'
  get 'queues/:ride_id/create/:park_pass_id' => 'quueue#create'
end
