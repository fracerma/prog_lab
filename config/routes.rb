Rails.application.routes.draw do
  
  root 'pages#home'

  resource :user, except: [:new]
  resolve('User') { [:user] }
  resources :sessions, only: [:create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'pages#login', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  #localhost:3000/locations/:id/types/show
  
  resources :locations

  #localhost:3000/types/:id/locations/show
  
  resources :categories
  resources :gatherings

  #generazione e modifica della location
  post '/gatherings/new/generate_locations', to: 'gatherings#generate_locations'
  post '/gatherings/edit/update_location', to: 'gatherings#update_location'

end


