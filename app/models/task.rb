# frozen_string_literal: true

class Task < ApplicationRecord
  has_many :challenges
  has_many :competitions, through: :challenges
  has_many :challengers
  has_many :users, through: :challengers
  has_many :solutions
  has_many :contestants, through: :solutions
  has_many :solvers, through: :contestants, source: :user

  validates :description, presence: true
  validates :spec, presence: true

  # returns either true or raises an error with the test output as message
  def test(solution_code)
    # TODO
    #
    # * store spec in text field
    # * for testing:
    #   * load solution code and insert into template class
    #   * create Tempfile with solution class
    #   * create Tempfile with loaded spec, require solution class in there
    #   * execute rspec (or would minitest be easier?) against spec in Tempfile
    #
    #   return { success: runner.message }
    # rescue StandardError => e # TODO: which exactly?
    #   return { failure: e.message }
  end
end
