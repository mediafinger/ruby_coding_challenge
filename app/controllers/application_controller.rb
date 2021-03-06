# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authenticate
    redirect_to :login unless current_user.present?
  end
  helper_method :authenticate

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # to avoid routing exceptions
  def route_not_found
    render "pages/error_404", status: :not_found
  end

  private

  # pass local variables to views instead of @instance variables
  # render without a view name uses the name of the action
  def locals(variables_hash)
    render locals: variables_hash
  end

  def redirect_non_owner
    return true if current_user.admin?
    return true if @record&.users&.include?(current_user)
    return true if @record&.user_id == current_user.id

    logger.warn "User #{current_user.id} tried to access #{controller}:#{action} for record #{@record.class} #{@record&.id}."
    flash[:alert] = "Forbidden: you don't have the necessary rights."
    redirect_to root_path, status: 403
  end
  helper_method :redirect_non_owner
end
