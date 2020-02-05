# frozen_string_literal: true

Rails.application.routes.draw do
  get '/sample', to: 'sample#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :account_activations, only: %i[edit]
  resources :password_resets, only: %i[new create edit update]

  resources :books, only: %i[] do
    get :search, on: :collection
  end

  root to: 'top#index'
end
