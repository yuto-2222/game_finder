Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'public/sessions#destroy'
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



  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end

  resources :users, only: [:show, :edit, :update]

  resources :games, except: [:show] do
    # member do
    #   get :create
    # end
    resources :reviews, except: [:edit, :update] do
      resources :comments, only: [:create] do
        member do
          get :destroy
        end
      end
    end
  end

end
