Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations'}

  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  resources :user_stocks, only: %i[create destroy]
  resources :users, only: %i[show]
  resources :friendships
end
