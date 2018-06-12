# frozen_string_literal: true

require "rails_helper"

RSpec.describe Challenger, type: :model do
  subject(:challenger) { build(:challenger) }

  it { expect(challenger.valid?).to eq(true) }
end
