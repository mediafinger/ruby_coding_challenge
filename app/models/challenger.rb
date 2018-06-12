# frozen_string_literal: true

class Challenger < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
