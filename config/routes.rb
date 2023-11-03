Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions: "admin/sessions",
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get '/about' => 'homes#about'



  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
  resources :games
  resources :reviews
  resources :comments

end
