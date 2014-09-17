Rails.application.routes.draw do
  resource :login,   controller: :login,   only: [:new, :create, :destroy]
  resource :welcome, controller: :welcome, only: [:show]

  concern :article do
    post :comment, on: :collection
    put  :search,  on: :collection
  end

  concern :mail do
    get :announce , on: :collection
    get :finish, on: :collection
  end

  resources :skill_profiles, concerns: :article
  resources :settings, only: [:edit, :update]
  resources :admin, only: [:index, :create] do
    get :login, on: :collection
  end
  resource  :reset_password, concerns: :mail

  get  '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
