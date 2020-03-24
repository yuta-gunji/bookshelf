# frozen_string_literal: true

Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :account_activations, only: %i[edit]
  resources :password_resets, only: %i[new create edit update]
  resources :relationships, only: %i[create destroy]
  resources :rankings, only: %i[index]

  resources :users, only: %i[index show edit update] do
    member do
      get :reviews
      get :followings
      get :followers
    end
  end

  resources :books, only: %i[index show], shallow: true do
    get :search, on: :collection
    resources :reviews, only: %i[create edit update] do
      resources :likes, only: %i[create destroy]
    end
  end

  resources :reviews, only: %i[index destroy]

  resources :bookshelves, only: %i[] do
    post :add_book, on: :collection
  end

  root to: 'top#index'
end
