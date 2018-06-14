# frozen_string_literal: true

require "rails_helper"

RSpec.describe Competition, type: :model do
  subject(:competition) { create(:competition) }

  it { expect(competition.valid?).to eq(true) }

  describe "#add_organizer" do
    let(:user) { create(:user) }

    it { expect(competition.add_organizer(user).pluck(:user_id)).to include(user.id) }
    it { expect(competition.add_organizer(user.id).pluck(:user_id)).to include(user.id) }

    context "invalid" do
      let(:wrong_type) { create(:competition) }

      it { expect(competition.add_organizer(wrong_type)).to eq [] }
      it { expect(competition.add_organizer(wrong_type.id)).to eq [] }
    end
  end
end
