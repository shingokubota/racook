Rails.application.routes.draw do
  root 'static_pages#home'
  get :about,   to: 'static_pages#about'
  get :terms,   to: 'static_pages#terms'
  get :signup,  to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :dishes
  resources :relationships, only: [:create, :destroy]
  get :favorites, to: 'favorites#index'
  post "favorites/:dish_id/create" => "favorites#create"
  delete "favorites/:dish_id/destroy" => "favorites#destroy"
  resources :notifications, only: :index
  get "/season", to: "seasons#season"
  get "/search", to: "seasons#search"
  get "/season_index", to: "seasons#index"
end