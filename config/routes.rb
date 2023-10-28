Rails.application.routes.draw do
  resources :stress_records do
    get 'search', on: :collection, defaults: { format: :turbo_stream }
    post 'set_session', on: :member
  end
  resources :stress_reliefs do
    get 'search', on: :collection, defaults: { format: :turbo_stream }
    resources :likes, only: %i[create destroy]
  end
  devise_for :users
  get 'home/index'
  get 'terms_of_service', to: 'home#terms_of_service', as: 'terms_of_service'
  get 'privacy_policy', to: 'home#privacy_policy', as: 'privacy_policy'
  root 'home#index'
end
