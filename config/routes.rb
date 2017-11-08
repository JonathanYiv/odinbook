Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  root 'static_pages#home'
  
  get '/contact', to: 'static_pages#contact'
  get '/about',   to: 'static_pages#about'

  resources :posts,       only:   [:create, :destroy]
  resources :likes,       only:   [:create, :destroy]
  resources :comments,    only:   [:create, :destroy]
  resources :users,       except: [:new, :create]
  resources :friendships, only:   [:index, :create, :destroy]
end
