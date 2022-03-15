Rails.application.routes.draw do


  devise_for :users

  #homes/controller
  root to: 'homes#top'

  #users/controller
  resources :users, only: [:index, :show, :edit, :create, :update] do
    collection do
      get '/profile/:id', to: 'users#profile', as: "profile"
    end
  end

  #animes/controller
  resources :animes, only: [:index, :show, :edit, :create, :update, :destroy]

end
