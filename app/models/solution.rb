# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :task

  has_many :contestants
  has_many :users, through: :contestants
end
