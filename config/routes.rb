Rails.application.routes.draw do
  resources :tournaments, only: [:index, :show] do
    resources :rounds, only: [:index, :show] do
      resources :matches, only: [:index, :show]
    end
  end
  resources :players, only: [:index, :show] do
    post 'draft' => 'players#draft', on: :member
  end

  resources :teams
  resources :users, except: [:index, :show]

  root 'dashboard#home'

  #sessions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
