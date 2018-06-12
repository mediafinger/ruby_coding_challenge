# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :competition
  belongs_to :task
end
