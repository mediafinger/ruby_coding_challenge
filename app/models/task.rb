# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  belongs_to :rating_method

  has_many :solutions
  has_many :contestants, through: :solutions
  has_many :solvers, through: :contestants, source: :user

  has_many :requirements
  has_many :specs, through: :requirements

  validates :description, presence: true
end
