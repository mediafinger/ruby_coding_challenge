# frozen_string_literal: true

Rails.application.routes.draw do
  get "login", to: redirect("/auth/github"), as: "login" # TODO: set flash[:notice]
  get Settings.github_callback_path, to: "sessions#create" # TODO: set flash[:notice]
  get "auth/failure", to: redirect("/") # TODO: set flash[:alert]
  delete "logout", to: "sessions#destroy", as: "logout" # TODO: set flash[:alert]

  resources :competitions, only: [:create, :new, :index, :show]

  root to: "pages#home"

  get "*unmatched_route", to: "application#route_not_found" # to avoid routing exceptions
end
