Rails.application.routes.draw do
  root to: 'home#index'
  resources :week_reports
  resources :skill_profiles
end
