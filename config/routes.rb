Rails.application.routes.draw do
  # devise_for :users
  devise_for :user, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  # authentification google

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'weather', to: 'pages#weather'
  get 'profil', to: 'pages#profil'
  get 'live', to: 'pages#live'
  get 'geolocation', to: 'pages#geolocation'

  resources :races, only: %i[index show new create destroy] do
    resource :waters, only: %i[show]
    resource :progressions, only: %i[show]
  end
end
