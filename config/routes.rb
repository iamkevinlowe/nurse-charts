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
  resources :patients, only: :show

  namespace :api do
    resources :users, only: [:index, :show, :create]
    resources :hospitals, only: :index
    resources :careplans, only: :create
    resources :issues, only: :create
    resources :goals, only: :create
    resources :reports, only: :create
    resources :patients, only: [:index, :show, :create]
    post 'patients/find', to: 'patients#find'
    resources :vitals, only: :create
    resources :temperatures, only: :create
    resources :pulse_rates, only: :create
    resources :respiration_rates, only: :create
    resources :blood_pressures, only: :create
  end

end
