# frozen_string_literal: true

FactoryBot.define do
  factory :solution do
    competition
    task
    code "puts 'hello world'"
  end
end
