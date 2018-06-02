# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spec, type: :model do
  subject(:spec) { build(:spec) }

  it { expect(spec.valid?).to eq(true) }
end
