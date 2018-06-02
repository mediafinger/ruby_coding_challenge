# frozen_string_literal: true

require "rails_helper"

RSpec.describe Challenge, type: :model do
  subject(:challenge) { build(:challenge) }

  it { expect(challenge.valid?).to eq(true) }
end
