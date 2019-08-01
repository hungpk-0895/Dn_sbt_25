Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    devise_for :users

    get "/about", to: "static_pages#about"
    get "/news", to: "static_pages#news"
    get "/offers", to: "static_pages#offers"
    get "/contact", to: "static_pages#contact"

    namespace :admin do
      resources :users, only: %i(index destroy)
      resources :categories
      resources :tours
      resources :bookings, only: %i(index update destroy)
      get "/booking/accept", to: "bookings#accept_booking"
      get "/booking/reject", to: "bookings#reject_booking"
    end
    get "/search", to: "searchs#index"
    resources :users
    resources :tours, only: %i(show index)
    resources :bookings
    resources :notifications
    resources :reviews, only: :create
  end
end
