Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  root to: "pages#home"
  get 'weather', to: 'pages#weather'
  get 'profil', to: 'pages#profil'
  get 'live', to: 'pages#live'
  get 'feedback', to: 'pages#feedback'
  get '/users/auth/google_oauth2/callback', to: 'users/omniauth_callbacks#google_oauth2'

  post '/feedback', to: 'feedback#create'

  resources :races, only: %i[index show new create destroy] do
    resource :waters, only: %i[show]
    resource :progressions, only: %i[show]
  end
end
