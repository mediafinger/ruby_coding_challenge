# frozen_string_literal: true

require "rails_helper"

RSpec.describe Organizer, type: :model do
  subject(:organizer) { build(:organizer) }

  it { expect(organizer.valid?).to eq(true) }
end
