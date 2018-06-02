# frozen_string_literal: true

class RatingAggregator < ApplicationRecord
  belongs_to :user

  has_many :challenges
end
