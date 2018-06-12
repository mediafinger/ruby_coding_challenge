# frozen_string_literal: true

class Contestant < ApplicationRecord
  belongs_to :user
  belongs_to :solution

  def calculate_rating
    rating.update!(solution.rate)
  end
end
