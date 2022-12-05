Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'weather', to: 'pages#weather'
  get 'profil', to: 'pages#profil'
  # Defines the root path route ("/")
  # root "articles#index"


  resources :races, only: %i[index show new create] do
    resource :waters, only: %i[show]
  end
end
