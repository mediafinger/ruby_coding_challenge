# frozen_string_literal: true

Rails.application.routes.draw do
  get "login", to: redirect("/auth/github"), as: "login" # TODO: set flash[:notice]
  get "auth/github/callback", to: "sessions#create" # TODO: set flash[:notice]
  get "auth/failure", to: redirect("pages#home") # TODO: set flash[:alert]
  delete "logout", to: "sessions#destroy", as: "logout" # TODO: set flash[:alert]

  root to: "pages#home"
end
