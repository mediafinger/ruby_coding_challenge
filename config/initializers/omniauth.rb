# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Settings.github_client_id, Settings.github_client_secret, scope: "read:user"
end

OmniAuth.config.full_host = Settings.github_callback_url

# NOTE: the omniauth-github gem has a bug
# therefore this monkey-patching is necessary :-/
OmniAuth::Strategies::GitHub.class_eval do
  def callback_url
    full_host # + script_name + callback_path
  end
end
