Rails.application.routes.draw do


  mount ActionCable.server => '/cable'
  
  get 'chats/index'
  get 'comments/index'
  get 'posts/index'
  devise_for :users,  :controllers => { registrations: 'registrations', confirmations: 'confirmations', omniauth_callbacks: 'omniauth_callbacks' } 
  
  resources :users do
    resources :chats, only: [:index, :show, :create] 
  	resources :posts do 
      resources :comments
    end
  end


  resources :chats, only: [:index, :show, :create]
  resources :messages, only:[:create]
  resources :welcome
  
  root 'home#index'
  
end
