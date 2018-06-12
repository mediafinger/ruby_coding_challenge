# frozen_string_literal: true

require "rails_helper"

RSpec.describe Competition, type: :model do
  subject(:competition) { build(:competition) }

  it { expect(competition.valid?).to eq(true) }
end
