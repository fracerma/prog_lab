Rails.application.routes.draw do
  

  devise_for :users
  root 'pages#home'

  resource :user, except: [:new]
  resolve('User') { [:user] }
  get '/users/all', to: 'users#index_users'
  get '/user/friends', to: 'users#index_friends'
  delete '/user/friends', to: 'users#remove_friend'
  post '/users/all', to: 'users#add_friend'

  #resources :sessions, only: [:create, :destroy]
  
  devise_scope :user do
    get '/sessions/user', to: 'devise/sessions#create', via: :post
  end

  get '/sessions/user', to: 'devise/sessions#create', via: :post
  
  #get 'signup', to: 'users#new', as: 'signup'
  #get 'login', to: 'pages#login', as: 'login'
  #get 'logout', to: 'sessions#destroy', as: 'logout'
  

  #localhost:3000/locations/:id/types/show
  
  resources :locations

  #localhost:3000/types/:id/locations/show
  
  resources :categories
  resources :gatherings

  #generazione e modifica della location
  post '/gatherings/new/generate_locations', to: 'gatherings#generate_locations'
  post '/gatherings/edit/update_location', to: 'gatherings#update_location'

  #get '/accept/location', to: 'locations#accept'
  get '/accept', to: 'locations#accept'
  post '/accept', to: 'locations#accept_locations'

  post '/accept', to: 'locations#accept_locations'

  get '/index_admin', to: 'locations#index_admin'


end


