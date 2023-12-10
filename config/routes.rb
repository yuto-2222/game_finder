Rails.application.routes.draw do

  get 'reports/new'
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'public/sessions#destroy'
    post '/users/guest_sign_in' => 'public/sessions#guest_sign_in'
    post '/users/guest_sign_out' => 'public/sessions#guest_sign_out'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions",
  }
  devise_scope :admin do
    get '/admin/sign_out' => 'admin/sessions#destroy'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get '/about' => 'homes#about'
  get '/genre/search' => 'searches#genre_search'
  get '/search' => 'searches#search'

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      patch :cancel
    end
  end

  resources :games, except: [:show] do
    resource :play_games, only: [:create, :destroy]
    resources :reviews do
      resource :usefuls, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :notifications, only: [:index, :destroy]

	resources :reports, only: [:new, :create, :index]

end
