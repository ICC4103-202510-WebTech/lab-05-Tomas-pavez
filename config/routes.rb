
Rails.application.routes.draw do
 
  devise_for :users

 
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :messages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :chats, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  
  get "up" => "rails/health#show", as: :rails_health_check

  root "chats#index"
end