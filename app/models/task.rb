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

  # returns either true or raises an error
  def test(solution_code = "def output(input); input.reverse; end;")
    testable = "class Testable; #{solution_code}; end"

    code = "require 'rspec'; describe Testable do; subject(:output) { described_class.output(input) }; let(:input) { 'hello' }; it { expect(output).to eq('olleh') }; end;"

    code.call(solution)
  end
end
