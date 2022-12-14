Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :clubs
  resources :users
  resources :beers
  resources :breweries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'
  
  resources :ratings, only: [:index, :new, :create, :destroy]
  
  get 'signup', to: 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'toggle_closed', on: :member
  end

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
end
