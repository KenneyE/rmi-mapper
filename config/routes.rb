Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    root to: "users#show", as: "user"
    get '/admins/new', to: "users#new_admin", as: :new_admin
    post '/admins', to: "users#create_admin", as: :create_admin
    resources :locations, shallow: true
  end

  resources :hospitals, shallow: true
  get '/search/:location_id', to: "hospitals#search", as: :hospital_search
end
