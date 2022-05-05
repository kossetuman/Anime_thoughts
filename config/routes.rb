Rails.application.routes.draw do

  #users/controller
  devise_for :users
  resources :users, only: [:index, :show, :edit, :create, :update] do
      resources :notifications, only: :index
      resource :relationship, only: [:create, :destroy]
      collection do
        #退会確認画面
        get :unsubscribe_confimation
        #論理削除用のルーティング
        patch :withdrawal
      end
      member do
        get :followings
        get :followers
        get :profile
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
