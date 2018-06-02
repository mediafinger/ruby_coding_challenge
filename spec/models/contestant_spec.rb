# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contestant, type: :model do
  subject(:contestant) { build(:contestant) }

  it { expect(contestant.valid?).to eq(true) }
end
