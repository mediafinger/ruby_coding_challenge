# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name "Andreas Finger"
    nick "mediafinger"
    provider "github"
    sequence(:provider_uid, 1000) { |n| n }
  end
end
