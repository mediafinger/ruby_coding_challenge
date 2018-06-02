# frozen_string_literal: true

require "rails_helper"

RSpec.describe Requirement, type: :model do
  subject(:requirement) { build(:requirement) }

  it { expect(requirement.valid?).to eq(true) }
end
