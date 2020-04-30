Rails.application.routes.draw do
  root 'pages#home'

  resource :user, except: [:new]
  resolve('User') { [:user] }
  resources :sessions, only: [:create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'pages#login', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
