Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "users#show", as: "user"
    resources :locations, shallow: true
  end
end
