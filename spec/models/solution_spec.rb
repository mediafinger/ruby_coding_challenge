# frozen_string_literal: true

require "rails_helper"

RSpec.describe Solution, type: :model do
  subject(:solution) { build(:solution) }

  it { expect(solution.valid?).to eq(true) }
end
