Rails.application.routes.draw do
  # devise_for :users
  devise_for :user, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  # authentification google

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'weather', to: 'pages#weather'
  get 'profil', to: 'pages#profil'
  get 'point_of_interest', to: 'pages#point_of_interest'
  # Defines the root path route ("/")
  # root "articles#index"

  resources :races, only: %i[index show new create] do
    resource :waters, only: %i[show]
    resource :progressions, only: %i[show]
  end
end
