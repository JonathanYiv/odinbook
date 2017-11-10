Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks'}
  #devise_scope :user do
    #delete '/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  #end

  root 'static_pages#home'
  
  get '/contact', to: 'static_pages#contact'
  get '/about',   to: 'static_pages#about'
  post '/accept', to: 'friendships#accept'

  resources :posts,       only:   [:create, :destroy]
  resources :likes,       only:   [:create, :destroy]
  resources :comments,    only:   [:create, :destroy]
  resources :users,       except: [:new, :create, :edit]
  resources :friendships, only:   [:index, :create, :destroy]
end
