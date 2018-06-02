# frozen_string_literal: true

class Contestant < ApplicationRecord
  belongs_to :user
  belongs_to :solution
end
