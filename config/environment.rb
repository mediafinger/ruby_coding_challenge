# frozen_string_literal: true

# Make ENV variables available
require_relative "settings"

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
