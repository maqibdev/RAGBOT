Rails.application.routes.draw do
  get "home/index"
  devise_for :users


  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: "home#index"
  resources :research_papers, only: [ :create ]


  # Defines the root path route ("/")
  # root "posts#index"
end
