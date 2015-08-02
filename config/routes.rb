Rails.application.routes.draw do
  resources :rounds
  resources :tournaments, only: [:index, :show] do
    post 'join' => 'tournaments#join', on: :member
    patch 'join' => 'tournaments#join', on: :member
    resources :matches, only: [:index, :show]
  end
  resources :players, only: [:index, :show] do
    post 'draft' => 'players#draft', on: :member
    get 'rankings' => 'players#rankings', on: :collection
  end

  resources :teams
  delete 'remove/:player_id' => 'teams#remove_player', as: :remove_player

  resources :users, except: [:index, :show]

  root 'dashboard#home'

  #sessions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
