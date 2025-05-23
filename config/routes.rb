Rails.application.routes.draw do
  root 'home#index'
  resources :school_events do
    member do
      get 'speak'
    end
  end
  resources :school_lunches do
    member do
      get 'speak'
    end
    resources :menu_ingredients
  end
  resources :foods
  resources :purchase_histories
  resources :statistics, only: [:index]
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
