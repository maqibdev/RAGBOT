Rails.application.routes.draw do
  devise_for :users

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: "chats#new"

  resources :chats, only: [ :index, :new, :create, :show ] do
    resources :queries, only: [ :create ]  # Nested route for queries within a chat
  end
end
