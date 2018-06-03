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

    expect_admin_section
    expect_interface_links

    create_challenge

    logout
  end

  private

  def expect_admin_section
    expect(page).to have_text("Admin Section")
    expect(page).to have_link("Create Challenge")
  end

  def expect_interface_links
    expect(page).to have_link("Challenges")
  end

  def create_challenge
    click_link("Create Challenge")
    expect(page).to have_text("New Challenge")
  end
end
