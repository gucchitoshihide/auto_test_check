Rails.application.routes.draw do
  root to: 'home#index'

  concern :article do
    post :comment, on: :collection
    put  :search,  on: :collection
  end

  resources :skill_profiles, concerns: :article
  resources :logins, only: [:index, :create, :destroy]
  resource  :reset_password

  get  '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
