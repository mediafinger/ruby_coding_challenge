# frozen_string_literal: true

class Settings
  def self.set(var_name, value)
    instance_variable_set("@#{var_name}", value)
  end

  # creates attribute and set values from `ENV[var_name]`,
  # falls back to `default` value when not set
  def self.register(var_name, default: nil)
    define_singleton_method(var_name) { instance_variable_get("@#{var_name}") }
    set(var_name, ENV.fetch(var_name.to_s.upcase, default))
  end

  # to compare a setting vs a value and 'ignore' type, no more Boolean or Number mis-comparisons
  def self.is?(var_name, other_value)
    public_send(var_name.to_sym).to_s == other_value.to_s
  end

  register :base_host,             default: "http://localhost:3000/"
  register :github_callback_path,  default: "auth/github/callback"
  register :github_callback_url,   default: Settings.base_host + Settings.github_callback_path
  register :github_client_id
  register :github_client_secret

  # Don't add secrets as 'default' values here!
  # Either set ENV vars for secrets
  # or add them to this file, which is in .gitignore:
  load "config/settings.local.rb" if File.exist?("config/settings.local.rb")
  # inside use this syntax:
  # Settings.set :password, "secret"
end
