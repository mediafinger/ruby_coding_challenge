# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_or_create_from" do
    subject(:user) { described_class.find_or_create_from(auth) }

    let(:auth) do
      {
        provider: "github",
        uid: "457782",
        info: {
          nickname: "mediafinger",
          email: nil,
          name: "Andreas Finger",
          image: "https://avatars0.githubusercontent.com/u/457782?v=4",
          urls: {
            GitHub: "https://github.com/mediafinger",
            Blog: "https://mediafinger.github.io/",
          },
        },
      }
    end

    context "when creation successful" do
      it { expect { user }.to change { User.count }.by(1) }
      it { expect(user.name).to         eq(auth.dig(:info, :name)) }
      it { expect(user.nick).to         eq(auth.dig(:info, :nickname)) }
      it { expect(user.image).to        eq(auth.dig(:info, :image)) }
      it { expect(user.url).to          eq(auth.dig(:info, :urls, :Blog)) }
      it { expect(user.provider).to     eq(auth[:provider]) }
      it { expect(user.provider_uid).to eq(auth[:uid]) }
    end

    context "when retrieval successful" do
      let!(:user_1) do
        described_class.create!(provider: auth[:provider], provider_uid: auth[:uid], nick: "Andy", email: "mail@example.com")
      end

      it { expect { user }.not_to change { User.count } }
      it { expect(user.id).to eq(user_1.id) }

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
end
