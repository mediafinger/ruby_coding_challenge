# frozen_string_literal: true

class Competition < ApplicationRecord
  has_many :challenges
  has_many :trials, through: :challenges, source: :task
  has_many :organizers
  has_many :users, through: :organizers
  has_many :solutions
  has_many :tasks, through: :solutions

  validates :description, presence: true
  validates :rating_method, presence: true
  validates :open_from, presence: true
  validates :open_until, presence: true

  def add_task(task)
    challenges.create!(task: task)
  end
  alias add_trial add_task

  def rate(code)
    rating_method.call(code)
  end
end
