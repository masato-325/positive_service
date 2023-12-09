Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "top#index"
  get "policy", to: "top#policy"

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :users, only: %i[new create]
  get "mypage", to: "users#show"

  resources :consultations, only: %i[new create show destroy] do
    resources :comments, only: %i[create destroy], shallow: true
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
