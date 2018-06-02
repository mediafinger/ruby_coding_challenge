# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Workflow", type: :feature do
  before do
  end

  scenario "User logs in, does stuff, and logs out again" do
    login_with_invalid_credentials

    login_succesfully

    logout
  end

  # workflows
  #
  def login_with_invalid_credentials
    mock_omniauth_invalid

    visit "/"
    click_link "Login with GitHub"

    expect(page).to have_link("Login with GitHub")
  end

  def login_succesfully
    mock_omniauth
    click_link "Login with GitHub"

    expect(page).to have_text("Andreas Finger")
    expect(page).to have_link("Logout")
  end

  def logout
    click_link "Logout"
    expect(page).to have_link("Login with GitHub")
  end

  # helper methods
  #
  def mock_omniauth
    # Short circuit OmniAuth to return default value to callback URL
    OmniAuth.config.test_mode = true

    # Set a default mock for the auth hash
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "123456",
      info: {
        email: "andy@mediafinger.com",
        image: "http://localhost:3000/mediafinger.png",
        name: "Andreas Finger",
        nickname: "mediafinger",
      },
      credentials: { token: "foobarbaz" },
    })
  end

  def mock_omniauth_invalid
    # Short circuit OmniAuth to return default value to callback URL
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    # Do not raise an exception when credentials are invalid
    OmniAuth.config.on_failure = proc { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
  end
end
