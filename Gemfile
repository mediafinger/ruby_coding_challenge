# frozen_string_literal: true

source "https://rubygems.org"

# To ensure https when installing from a repo:
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "rails", "~> 5.2.0"

gem "bootsnap", ">= 1.1.0", require: false
gem "haml-rails", "~> 1.0"
gem "lograge"
gem "omniauth-github", "~>  1.3"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "redcarpet", "~> 3.4"
gem "rouge", "~> 3.1"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 3.5"

group :development do
  gem "web-console", ">= 3.3.0"
end

group :development, :test do
  gem "awesome_print", "~> 1.8"
  gem "bundler-audit", "~> 0.6"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails", "~> 4.8"
  gem "rspec-rails", "~> 3.7"
  gem "rubocop", "0.56.0", require: false
end

group :test do
  gem "capybara", "~> 2.18"
  gem "rubocop-rspec", "~> 1.25"
end

# gem "bcrypt", "~> 3.1.7" # Use ActiveModel has_secure_password
# gem "capistrano-rails", group: :development # Use Capistrano for deployment
# gem "fast_jsonapi" # Fast JSON:API serializer from Netflix

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
