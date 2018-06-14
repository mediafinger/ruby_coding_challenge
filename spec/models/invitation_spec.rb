# frozen_string_literal: true

require "rails_helper"

RSpec.describe Invitation, type: :model do
  subject(:invitation) { build(:invitation, creator: creator, invitee: invitee, entity: entity) }

  let(:creator) { create(:user) }
  let(:invitee) { create(:user) }

  describe "valid" do
    let(:entity) { create(:competition) }

    before { create(:organizer, user: creator, competition: entity) }

    context "when the invitation creator owns the entity" do
      it { expect(invitation.valid?).to eq(true) }
      it { expect(invitation.answer).to eq(nil) }
      it { expect(invitation.expires_at).to be_within(2.seconds).of(7.days.from_now) }
    end

    context "when the invitation creator is an admin" do
      let(:creator) { create(:user, :admin) }

      it { expect(invitation.valid?).to eq(true) }
      it { expect(invitation.answer).to eq(nil) }
      it { expect(invitation.expires_at).to be_within(2.seconds).of(7.days.from_now) }
    end
  end

  describe "invalid" do
    context "when the invitation creator does not own the entity" do
      let(:entity) { create(:competition) }

      it "adds entity errors", :aggregated_failures do
        expect(invitation.valid?).to eq(false)
        expect(invitation.errors[:entity]).to match(["must be owned by creator"])
      end
    end

    context "when the invitee already owns the entity" do
      let(:entity) { create(:competition) }

      before { create(:organizer, user: invitee, competition: entity) }

      it "adds entity errors", :aggregated_failures do
        expect(invitation.valid?).to eq(false)
        expect(invitation.errors[:entity]).to match(["must be owned by creator"])
      end
    end

    context "when the entity type is uninvitable" do
      let(:entity) { build(:challenger) }

      it "adds entity errors", :aggregated_failures do
        expect(invitation.valid?).to eq(false)
        expect(invitation.errors[:entity]).to match_array(
          [
            "must be one of [\"Competition\", \"Task\", \"Solution\"]",
            "must be owned by creator",
          ]
        )
      end
    end
  end

  describe "#accept" do
    context "when invited to a competition" do
      let(:entity) { create(:competition) }

      before { create(:organizer, user: creator, competition: entity) }

      it { expect(invitation.valid?).to eq(true) }

      it "updates the invitation and creates an association", :aggregated_failures do
        expect(invitation.accept).to match_array([creator, invitee])
        expect(invitation.reload.answer).to eq(true)
        expect(invitation.reload.expires_at).to be_within(1.second).of(Time.now)
      end

      it "expires all duplicates", :aggregated_failures do
        another_invite = create(:invitation, creator: creator, invitee: invitee, entity: entity)

        expect(invitation.accept).to match_array([creator, invitee])
        expect(invitation.reload.answer).to eq(true)
        expect(invitation.reload.expires_at).to be_within(1.second).of(Time.now)

        expect(another_invite.reload.answer).to eq(nil)
        expect(another_invite.reload.expires_at).to be_within(1.second).of(Time.now)
      end
    end

    context "when invited to a task" do
      let(:entity) { create(:task) }

      before { create(:challenger, user: creator, task: entity) }

      it { expect(invitation.valid?).to eq(true) }

      it "updates the invitation and creates an association", :aggregated_failures do
        expect(invitation.accept).to match_array([creator, invitee])
        expect(invitation.reload.answer).to eq(true)
        expect(invitation.reload.expires_at).to be_within(1.second).of(Time.now)
      end
    end

    context "when invited to a solution" do
      let(:entity) { create(:solution) }

      before { create(:contestant, user: creator, solution: entity) }

      it { expect(invitation.valid?).to eq(true) }

      it "updates the invitation and creates an association", :aggregated_failures do
        expect(invitation.accept).to match_array([creator, invitee])
        expect(invitation.reload.answer).to eq(true)
        expect(invitation.reload.expires_at).to be_within(1.second).of(Time.now)
      end
    end
  end

  describe "#decline" do
    let(:entity) { create(:competition) }

    before { create(:organizer, user: creator, competition: entity) }

    it { expect(invitation.valid?).to eq(true) }

    it "updates the invitation and creates an association", :aggregated_failures do
      expect(invitation.decline).to match_array([creator])
      expect(invitation.reload.answer).to eq(false)
      expect(invitation.reload.expires_at).to be_within(1.second).of(Time.now)
    end
  end
end
