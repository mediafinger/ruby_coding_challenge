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

  register :github_callback_url,  default: "http://localhost:3000/auth/github/callback"
  register :github_client_id
  register :github_client_secret
end

# Either set ENV vars or add secrets to this file, which is in .gitignore
require 'settings.local.rb' if File.exists?('settings.local.rb')
# inside use this syntax:
# Settings.register :password, default: "secret"
