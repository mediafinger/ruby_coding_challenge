# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from(request.env["omniauth.auth"])
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    session.clear

    redirect_to root_path
  end
end
