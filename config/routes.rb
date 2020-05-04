Rails.application.routes.draw do
  
  root 'pages#home'

  resource :user, except: [:new]
  resolve('User') { [:user] }
  resources :sessions, only: [:create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'pages#login', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  #localhost:3000/locations/:id/types/show
  resources :locations do 
    resources :types
  end

  #localhost:3000/types/:id/locations/show
  resources :types do 
    resources :locations
  end

  resources :categories
  resources :gatherings

  #pagina delle locations che vanno bene per tutti gli invitati
  get '/gatherings/new/generate_locations', to: 'gatherings#generate_locations'

end


