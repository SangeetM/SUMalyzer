Rails.application.routes.draw do
  devise_for :users
  resources :observations, except: [:show]
  resources :patients
  root to: 'pages#index'
end
