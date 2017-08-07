Rails.application.routes.draw do
 
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/friends', to: 'static_pages#friends'
  get '/signup', to: 'users#new'
  get '/newList', to: 'lists#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  delete '/deleteItem', to: 'items#destroy'
  delete '/deleteList', to: 'lists#destroy'
  get '/shareList', to: 'lists#share'
 
  resources :users
  resources :lists
end
