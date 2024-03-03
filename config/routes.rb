Rails.application.routes.draw do
  devise_for :users

  #Putting this after the devise routes to give devise precedences
  resources :users, only: [:show, :index] do
    resources :events, only: [:index] # This will generate a route for showing events associated with a user
  end
  get 'events/index'

  root 'events#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
