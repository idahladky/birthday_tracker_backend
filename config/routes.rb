Rails.application.routes.draw do
  resources :months
  resources :birthdays
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login" #for testing
end
