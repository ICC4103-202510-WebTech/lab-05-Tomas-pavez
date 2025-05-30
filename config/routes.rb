Rails.application.routes.draw do
  # Devise solo para autenticación
  devise_for :users

  # Recursos personalizados
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :messages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :chats, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Página de salud de Rails
  get "up" => "rails/health#show", as: :rails_health_check

  # Página raíz
  root "chats#index"
end

