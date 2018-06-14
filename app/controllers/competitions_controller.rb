# frozen_string_literal: true

class CompetitionsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :find_record, only: [:show, :edit, :update]
  before_action :redirect_non_owner, except: [:index, :show] # only admin can use #new and #create

  def index
    locals(competitions: Competition.all)
  end

  def show
    locals(competition: @record)
  end

  def new
    locals(competition: Competition.new)
  end

  def create
    competition = Competition.new(competition_params.to_h)

    if competition.save
      competition.add_organizer(current_user)
      flash[:notice] = "Competition was successfully created."
      redirect_to competition_path(competition)
    else
      flash[:alert] = "Error: Competition not created."
      render :new, locals: { competition: competition }
    end
  end

  def edit
    locals(competition: @record)
  end

  def update
    locals(competition: @record)
  end

  private

  def find_record
    @record = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:description, :open_from, :open_until, :rating_method)
  end
end
