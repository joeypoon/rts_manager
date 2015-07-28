Rails.application.routes.draw do
  resources :tournaments, only: [:index, :show] do
    post 'join' => 'tournaments#join', on: :member
    resources :rounds, only: [:index, :show] do
      resources :matches, only: [:index, :show]
    end
  end
  resources :players, only: [:index, :show] do
    post 'draft' => 'players#draft', on: :member
  end

  resources :teams do
    get 'rankings' => 'teams#rankings', on: :collection
  end
  resources :users, except: [:index, :show]

  root 'dashboard#home'

  #sessions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
