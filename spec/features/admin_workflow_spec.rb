# frozen_string_literal: true

require_relative "features_helper.rb"

RSpec.feature "AdminWorkflow", type: :feature do
  let(:provider)     { "github" }
  let(:provider_uid) { "20359" }

  before do
    create(:user, :admin, provider: provider, provider_uid: provider_uid)
  end

  scenario "User logs in, does stuff, and logs out again" do
    login_with_invalid_credentials

    login_succesfully(omniauth_hash: build(:github_auth_hash, provider: provider, uid: provider_uid))

    expect_admin_section
    expect_interface_links

    create_competition

    logout
  end

  private

  def expect_admin_section
    expect(page).to have_text("Admin Section")
    expect(page).to have_link("Create Competition")
  end

  def expect_interface_links
    expect(page).to have_link("Competitions")
  end

  def create_competition
    click_link("Create Competition")
    expect(page).to have_text("New Competition")

    fill_in "competition_description", with: "Ruby Golf"
    # fill_in "competition_open_until", with: 7.days.from_now.to_s
    click_button "Submit"

    expect(page).to have_text("Error: Competition not created.")

    select_date(date: Date.today + 3.days, field: "competition_open_from")
    # fill_in "competition_rating_method", with: "2"
    click_button "Submit"

    expect(page).to have_text("Competition was successfully created.")
    expect(page).to have_text("Ruby Golf")
  end
end
