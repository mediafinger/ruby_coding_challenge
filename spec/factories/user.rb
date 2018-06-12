# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name "Andreas Finger"
    nick "mediafinger"
    provider "github"
    provider_uid { rand(9999999) }

    trait :admin do
      roles [:admin]
    end
  end
end
