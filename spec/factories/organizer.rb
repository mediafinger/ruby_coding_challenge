# frozen_string_literal: true

FactoryBot.define do
  factory :organizer do
    user
    competition
  end
end
