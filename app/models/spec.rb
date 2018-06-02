# frozen_string_literal: true

class Spec < ApplicationRecord
  belongs_to :user

  has_many :requirements
  has_many :tasks, through: :requirements
end
