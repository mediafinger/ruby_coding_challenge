# frozen_string_literal: true

FactoryBot.define do
  factory :competition do
    description "Welcome to the competition"
    rating_method "1"
    open_from { Time.zone.now }
    open_until { 7.days.from_now }
  end
end
