Rails.application.routes.draw do
  get 'comments/create'

  root to: 'home#index'

  resources :week_reports
  resources :skill_profiles
  resources :comments, only: [:create]
end
