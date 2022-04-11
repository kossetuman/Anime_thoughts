Rails.application.routes.draw do

  #users/controller
  devise_for :users
  resources :users, only: [:index, :show, :edit, :create, :update] do
      resources :notifications, only: :index
      resource :relationship, only: [:create, :destroy]
      get :followings, on: :member
      get :followers, on: :member
    collection do
      get '/profile/:id', to: 'users#profile', as: "profile"
      #退会確認画面
      get :unsubscribe_confirmation
      #論理削除用のルーティング
      patch '/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    end
  end

  #homes/controller
  root to: 'homes#top'

  #animes/controller
  resources :animes, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end





end
