Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { registrations: "user/registrations" }

  resources :products, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      put "active" => "products#active_toggle"
    end
  end
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
