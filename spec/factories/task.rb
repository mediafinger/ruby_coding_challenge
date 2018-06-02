# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user
    challenge
    rating_method
    description "Solve this!"
    open_from { Time.zone.now }
    open_until { 7.days.from_now }
  end
end
