Rails.application.routes.draw do
  root to: 'home#index'

  concern :article do
    post :comment, on: :collection
  end

  resources :week_reports,   concerns: :article
  resources :skill_profiles, concerns: :article
  resources :logins, only: [:index, :create, :destroy]
end
