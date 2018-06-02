# frozen_string_literal: true

require "rails_helper"

RSpec.describe Creation, type: :model do
  subject(:creation) { build(:creation) }

  it { expect(creation.valid?).to eq(true) }
end
