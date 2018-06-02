# frozen_string_literal: true

class Requirement < ApplicationRecord
  belongs_to :task
  belongs_to :spec
end
