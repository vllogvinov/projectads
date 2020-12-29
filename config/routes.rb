Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :announcements
  devise_for :users
	# root 'sessions#new', scope: :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "announcements#index"
  resources :users do
  	member do
  		get :confirm_email
      get :announcements
  	end
  end
end
