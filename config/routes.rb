# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :comments
  root 'home#index'

  devise_for :users, path: 'auth'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :recipes do
    resources :comments, only: %i[create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
