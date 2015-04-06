Rails.application.routes.draw do

  root to: 'groups#index'

  devise_for :users
  resources :users, only: [:show, :index]

  resources :games
end
