# frozen_string_literal: true

class RatingMethod < ApplicationRecord
  belongs_to :user

  has_many :tasks
end
