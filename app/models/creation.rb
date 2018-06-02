# frozen_string_literal: true

class Creation < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
end
