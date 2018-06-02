# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :rating_aggregator

  has_many :creations
  has_many :users, through: :creations

  has_many :tasks

  validates :description, presence: true
end
