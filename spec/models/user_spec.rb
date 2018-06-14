# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_or_create_from" do
    subject(:user) { described_class.find_or_create_from(auth) }

    let(:auth) { build(:github_auth_hash) }

    context "when creation successful" do
      it { expect { user }.to change { User.count }.by(1) }
      it { expect(user.name).to         eq(auth.dig(:info, :name)) }
      it { expect(user.nick).to         eq(auth.dig(:info, :nickname)) }
      it { expect(user.image).to        eq(auth.dig(:info, :image)) }
      it { expect(user.url).to          eq(auth.dig(:info, :urls, :Blog)) }
      it { expect(user.provider).to     eq(auth[:provider]) }
      it { expect(user.provider_uid).to eq(auth[:uid].to_s) }
    end

    context "when retrieval successful" do
      let!(:user_1) do
        described_class.create!(provider: auth[:provider], provider_uid: auth[:uid], nick: "Andy", email: "mail@example.com")
      end

      it { expect { user }.not_to change { User.count } }
      it { expect(user.id).to eq(user_1.id) }
      it { expect(user.admin?).to eq(false) }

      it "updates current user information" do
        expect(user.email).to eq(auth.dig(:info, :email))
        expect(user.name).to  eq(auth.dig(:info, :name))
        expect(user.nick).to  eq(auth.dig(:info, :nickname))
        expect(user.image).to eq(auth.dig(:info, :image))
        expect(user.url).to   eq(auth.dig(:info, :urls, :Blog))
      end
    end

    context "when it fails" do
      let(:auth) { {} }

      it { expect { user }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe "#add_role" do
    let(:user) { build(:user) }

    it "adds role as string", :aggregate_failures do
      expect(user.roles).to eq []

      user.add_role(:admin)

      expect(user.roles).to eq ["admin"]
      expect(user.admin?).to eq(true)
    end

    it "does not add a role twice", :aggregate_failures do
      user.add_role("editor")
      user.add_role(:editor)
      expect(user.roles).to eq ["editor"]
    end
  end

  describe "#admin?" do
    let(:user) { build(:user) }
    let(:admin_user) { build(:user, :admin) }

    it "will identify the admin_user as admin", :aggregate_failures do
      expect(user.admin?).to eq(false)
      expect(admin_user.admin?).to eq(true)
    end
  end
end
