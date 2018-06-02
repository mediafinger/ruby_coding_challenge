# frozen_string_literal: true

require "rails_helper"

RSpec.describe Invitation, type: :model do
  subject(:invitation) { build(:invitation) }

  it { expect(invitation.valid?).to eq(true) }
end
