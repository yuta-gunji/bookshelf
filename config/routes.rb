# frozen_string_literal: true

Rails.application.routes.draw do
  get '/sample', to: 'sample#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'top#index'
end
