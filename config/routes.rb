Rails.application.routes.draw do
  get "message/index"
  get "chat/index"
  get "user/index"
  get "message/show"
  get "chat/show"
  get "user/show"
  get "message/new"
  get "chat/new"
  get "user/new"
  get "message/create"
  get "chat/create"
  get "user/create"

  
  resources :chats
  resources :messages
  resources :users, only: [:index, :show, :new, :create]
  resources :messages, only: [:index, :show, :new, :create]
  resources :chats, only: [:index, :show, :new, :create]
  
  get "up" => "rails/health#show", as: :rails_health_check
end
