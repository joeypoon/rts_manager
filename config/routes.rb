Rails.application.routes.draw do
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
