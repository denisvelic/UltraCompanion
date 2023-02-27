Rails.application.routes.draw do
  # devise_for :users
  devise_for :user, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  # authentification google

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'weather', to: 'pages#weather'
  get 'profil', to: 'pages#profil'
  get 'live', to: 'pages#live'
  get 'point_of_interest', to: 'pages#point_of_interest'

  post '/auth/:provider/callback', to: 'auth#create'
  get '/auth/failure', to: redirect('/')
  delete '/logout', to: 'auth#destroy', as: :logout
  get '/auth/strava', as: :strava_login

  namespace :strava do
    resource :oauth, only: [] do
      collection do
        patch :connect
      end
    end
    resource :oauth_redirect, only: [] do
      collection do
        get :complete_connection
      end
    end
  end
  # strava

  resources :races, only: %i[index show new create destroy] do
    resource :waters, only: %i[show]
    resource :progressions, only: %i[show]
  end
end
