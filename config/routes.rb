Rails.application.routes.draw do
  resources :stress_records do
    get 'search', on: :collection, defaults: { format: :turbo_stream }
  end
  resources :stress_reliefs do
    get 'search', on: :collection, defaults: { format: :turbo_stream }
    resources :likes, only: %i[create destroy]
  end
  devise_for :users
  get 'home/index'
  root 'home#index'
end
