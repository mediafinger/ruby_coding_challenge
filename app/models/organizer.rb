# frozen_string_literal: true

class Organizer < ApplicationRecord
  belongs_to :user
  belongs_to :competition
end
