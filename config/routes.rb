# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :announcements
  devise_for :users
  root 'announcements#index'
  resources :users do
    member do
      get :confirm_email
      get :announcements
    end
  end
end
