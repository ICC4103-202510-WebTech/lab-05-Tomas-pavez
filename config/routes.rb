Rails.application.routes.draw do
  get "message/index"
  get "chat/index"
  get "user/index"
  get "message/show"
  get "chat/show"
  get "user/show"

  
  resources :chats
  resources :messages
  resources :users, only: [:index, :show]
  resources :messages, only: [:index, :show]
  resources :chats, only: [:index, :show]
  
  get "up" => "rails/health#show", as: :rails_health_check
end
