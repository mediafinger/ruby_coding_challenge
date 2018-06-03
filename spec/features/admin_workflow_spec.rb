# frozen_string_literal: true

require_relative "features_helper.rb"

RSpec.feature "AdminWorkflow", type: :feature do
  before do
    create(:user, :admin, provider: provider, provider_uid: provider_uid)
  end

  let(:provider)     { "github" }
  let(:provider_uid) { "20359" }

  scenario "User logs in, does stuff, and logs out again" do
    login_with_invalid_credentials

    login_succesfully(omniauth_hash: build(:github_auth_hash, provider: provider, uid: provider_uid))

    logout
  end
end
