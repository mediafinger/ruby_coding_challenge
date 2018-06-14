# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    creator { build(:user) }
    invitee { build(:user) }
    entity  { build(:solution) }
    expires_at { Time.zone.now + 7.days }
  end
end
