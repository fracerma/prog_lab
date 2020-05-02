Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "main#index"

  #localhost:3000/locations/:id/types/show
  resources :locations do 
    resources :types
  end

  #localhost:3000/types/:id/locations/show
  resources :types do 
    resources :locations
  end

  resources :categories
  

end


