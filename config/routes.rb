# frozen_string_literal: true

Rails.application.routes.draw do
  resources :recipes
  devise_for :users, path: 'auth'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
