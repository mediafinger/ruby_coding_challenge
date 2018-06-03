# frozen_string_literal: true

class ChallengesController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :redirect_non_admin, except: [:index, :show]

  def index
  end

  def show
  end

  def new
  end

  def create
  end
end
