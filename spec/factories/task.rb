# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    description "Solve this!"
    spec "true"
    open_from { Time.zone.now }
    open_until { 7.days.from_now }
  end
end
