# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    creator { build(:user) }
    invitee { build(:user) }
    entity  { build(:solution) }
    expires_at { 7.days.from_now }
  end
end
