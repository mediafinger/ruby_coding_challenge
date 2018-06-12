# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :competition
  belongs_to :task

  has_many :contestants
  has_many :users, through: :contestants

  def rate
    competition.rate(code)
  end

  def test
    task.test(code)
  end
end
