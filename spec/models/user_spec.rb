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

      describe "#admin?" do
        before do
          user_1.roles << :admin
          user_1.save!
        end

        it "will retrieve the admin user", :aggregate_failures do
          expect(user_1.admin?).to eq(true)

          expect { user }.not_to change { User.count }

          expect(user.id).to eq(user_1.id)
          expect(user.admin?).to eq(true)
        end
      end
    end

    context "when it fails" do
      let(:auth) { {} }

      it { expect { user }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
