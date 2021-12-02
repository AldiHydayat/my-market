Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { registrations: "user/registrations" }

  resources :products, only: [:index, :new, :create]
  resources :categories, only: [:index, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
