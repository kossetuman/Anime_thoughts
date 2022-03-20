Rails.application.routes.draw do

  #users/controller
  devise_for :users
  resources :users, only: [:index, :show, :edit, :create, :update] do
      resource :relationships, only: [:create, :destroy]
      get :followings, on: :member
      get :followers, on: :member
    collection do
      get '/profile/:id', to: 'users#profile', as: "profile"
    end
  end

  #homes/controller
  root to: 'homes#top'

  

  #animes/controller
  resources :animes, only: [:index, :show, :edit, :create, :update, :destroy]
  
  #検索機能
  get "/search", to: "searches#search", as: "search"

end
