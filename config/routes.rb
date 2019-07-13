Rails.application.routes.draw do
  get 'users/new'
  get 'pages/home'
  get 'pages/about'
  resources :articles

  root 'pages#home'

  get '/about', to: 'pages#about'

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # post 'users', to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
