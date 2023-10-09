Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "top#index"

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :users, only: %i[new create]

  resources :consultations, except: [:show]
  get 'consultations/show', to: 'consultations#show', as: 'consultation_show'
  # Defines the root path route ("/")
  # root "articles#index"
end
