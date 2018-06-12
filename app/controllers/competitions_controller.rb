# frozen_string_literal: true

class CompetitionsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :redirect_non_admin, except: [:index, :show]

  def index
    @competitions = Competition.all
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = current_user.competitions.new(competition_params.to_h)

    if @competition.save
      flash[:notice] = "Competition was successfully created."
      redirect_to competition_path(@competition)
    else
      flash[:alert] = "Error: Competition not created."
      render :new
    end
  end

  private

  def competition_params
    params.require(:competition).permit(:description, :open_from, :open_until, :rating_method)
  end
end
