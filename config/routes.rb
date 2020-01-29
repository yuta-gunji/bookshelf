# frozen_string_literal: true

Rails.application.routes.draw do
  get '/sample', to: 'sample#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :account_activation, only: %i[edit]
  root to: 'top#index'
end
