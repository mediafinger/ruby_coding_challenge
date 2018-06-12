# frozen_string_literal: true

require_relative "features_helper.rb"

RSpec.feature "ContestantWorkflow", type: :feature do
  before do
  end

  scenario "User logs in, does stuff, and logs out again" do
    login_with_invalid_credentials

    login_succesfully

    expect_interface_links
    expect_admin_section_to_be_forbidden

    logout
  end

  def expect_interface_links
    expect(page).to have_link("Competitions")
  end

  def expect_admin_section_to_be_forbidden
    expect(page).not_to have_text("Admin Section")

    visit("/competitions/new")
    expect(page).to have_current_path("/")
    # expect(find(".flash.alert")).to have_content("Forbidden: you don't have 'admin' rights.")
  end
end
