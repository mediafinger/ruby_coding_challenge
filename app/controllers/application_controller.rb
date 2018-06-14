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

  # rubocop:disable Style/GuardClause
  def redirect_non_admin
    unless current_user.admin?
      flash[:alert] = "Forbidden: you don't have 'admin' rights."
      redirect_to root_path
    end
  end
  helper_method :redirect_non_admin
  # rubocop:enable Style/GuardClause

  # to add custom log information for lograge, e.g. a trace_id
  # def append_info_to_payload(payload)
  #   super
  #   payload[:host] = request.host
  #   payload[:params] = request.filtered_parameters
  #   payload[:trace_id] = request.headers.trace_id
  # end
end
