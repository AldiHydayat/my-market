Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { registrations: "user/registrations" }

  get "404" => "errors#not_found", as: "error_not_found"

  get "search" => "products#search"
  get "product_summary/:id" => "order_details#summary", as: "summary"
  get "wishlist" => "products#my_wishlist", as: "my_wishlist"

  resources :products, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :reviews, except: %i[destroy]

    member do
      put "active" => "products#active_toggle"
      put "wishlist" => "products#wishlist_toggle"
    end
  end

  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :carts, only: [:index, :destroy, :create]

  resources :orders, only: [:index, :create] do
    collection do
      post "checkout" => "orders#checkout"
      get "my_order" => "orders#my_order"
    end

    member do
      put "confirm_order" => "orders#confirm_order"
      put "deliver_order" => "orders#deliver_order"
      put "order_succeed" => "orders#order_succeed"
      get "invoce" => "orders#invoice"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
