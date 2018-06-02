# frozen_string_literal: true

FactoryBot.define do
  factory :challenge do
    rating_aggregator
    description "Welcome to the challenge"
    open_from { Time.zone.now }
    open_until { 7.days.from_now }
  end
end
