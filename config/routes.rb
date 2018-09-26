Rails.application.routes.draw do

  root 'pages#accueil'
  get 'pages/contact'
  get 'pages/team'
  get 'pages/services'
  # connection / deconnection
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # all resources
  resources :users
end
