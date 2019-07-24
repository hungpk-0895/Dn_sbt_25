Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/about", to: "static_pages#about"
    get "/news", to: "static_pages#news"
    get "/offers", to: "static_pages#offers"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :admin do
      resources :users, only: %i(index destroy)
      resources :categories
      resources :tours
      resources :bookings, only: %i(index update destroy)
      get "/booking/accept", to: "bookings#accept_booking"
      get "/booking/reject", to: "bookings#reject_booking"
    end
    resources :users
    resources :tours, only: %i(index show)
    resources :bookings
    resources :notifications
    resources :reviews, only: :create
  end
end
