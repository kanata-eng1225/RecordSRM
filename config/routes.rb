Rails.application.routes.draw do
  resources :stress_records
  resources :stress_reliefs do
    resources :likes, only: [:create, :destroy]
  end
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
