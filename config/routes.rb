Geochat::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "log_out"
  get "login" => "sessions#new", :as => "log_in"
  get "signup" => "users#new", :as => "sign_up"
  root :to => "users#new"
  resources :users
  resources :sessions
end
