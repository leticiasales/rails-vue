Rails.application.routes.draw do
  resources :employees
  resources :positions

  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  root to: 'application#not_found'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end