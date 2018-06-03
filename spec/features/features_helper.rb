# frozen_string_literal: true

require "rails_helper"

def login_succesfully(omniauth_hash: build(:github_auth_hash))
  mock_omniauth(omniauth_hash: omniauth_hash)
  click_link "Login with GitHub"

  expect(page).to have_text(omniauth_hash.dig(:info, :name))
  expect(page).to have_link("Logout")
end

def login_with_invalid_credentials
  mock_omniauth_invalid

  visit "/"
  click_link "Login with GitHub"

  expect(page).to have_link("Login with GitHub")
end

def logout
  click_link "Logout"
  expect(page).to have_link("Login with GitHub")
end

# helper methods
#
def mock_omniauth(omniauth_hash:)
  # Short circuit OmniAuth to return default value to callback URL
  OmniAuth.config.test_mode = true

  # Set a default mock for the auth hash
  OmniAuth.config.mock_auth[:github] = omniauth_hash
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
