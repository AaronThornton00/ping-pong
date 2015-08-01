Rails.application.routes.draw do

  root to: 'games#index'

  devise_for :users
  resources :users, only: [:show, :index]

  resources :games
end
