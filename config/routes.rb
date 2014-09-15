Rails.application.routes.draw do
  root to: 'home#index'

  concern :article do
    post :comment, on: :collection
    put  :search,  on: :collection
  end

  concern :mail do
    get :announce , on: :collection
    get :finish, on: :collection
  end

  resources :skill_profiles, concerns: :article
  resources :logins,   only: [:index, :create, :destroy]
  resources :settings, only: [:edit, :update]
  resources :admin, only: [:index, :create] do
    get :login, on: :collection
  end
  resource  :reset_password, concerns: :mail

  get  '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
