Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'sessions'
  }

  devise_scope :user do
    post '/session', to: 'sessions#create'
    delete '/session', to: 'sessions#destroy'

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end  
  end

  resources :users, only: :show

  namespace :api do
    resources :users, only: [:index, :show, :create]
    resources :hospitals, only: [:index, :show]
  end

end
