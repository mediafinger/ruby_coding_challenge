# frozen_string_literal: true

FactoryBot.define do
  factory :contestant do
    user
    solution
  end
end
