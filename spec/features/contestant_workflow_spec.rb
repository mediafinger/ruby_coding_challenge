# frozen_string_literal: true

require_relative "features_helper.rb"

RSpec.feature "ContestantWorkflow", type: :feature do
  before do
  end

  scenario "User logs in, does stuff, and logs out again" do
    login_with_invalid_credentials

    login_succesfully

    logout
  end
end
