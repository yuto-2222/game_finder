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
    resources :genres, only: [:index, :create, :edit, :update]
  end

  resources :users, only: [:show, :edit, :update]
  resources :games, except: [:show] do
    member do
      get :create
    end
    resources :reviews, except: [:edit, :update] do
      resources :comments, only: [:create] do
        member do
          get :destroy
        end
      end
    end
  end

end
