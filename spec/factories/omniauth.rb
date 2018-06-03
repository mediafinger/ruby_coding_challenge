# frozen_string_literal: true

FactoryBot.define do
  factory :github_auth_hash, class: OmniAuth::AuthHash do
    skip_create

    # Setup variables that can be used later:
    ignore do
      id { SecureRandom.random_number(1_000_000_000).to_s }
      email "andy@example.com"
      name { "#{first_name} #{last_name}" }
      nickname "mediafinger"
      image_url "https://avatars0.githubusercontent.com/u/457782?v=4"

      first_name "Andreas"
      last_name "Finger"
      link { "http://www.github.com/#{nickname}" }

      locale "en_US"
      location_id "123456789"
      location_name "Barcelona, Spain"
      timezone("Europe/Berlin")
      updated_time { SecureRandom.random_number(1.month).seconds.ago }
      token { SecureRandom.urlsafe_base64(100).delete("-_").first(100) }
      expires_at { SecureRandom.random_number(1.month).seconds.from_now }
    end

    # The actual response of this factory:
    #
    provider "github"
    uid { id }
    info do
      {
        email: nil,
        image: image_url,
        name: name,
        nickname: nickname,
        urls: {
          GitHub: link,
          Blog: "https://mediafinger.github.io/",
        },
      }
    end
    credentials do
      {
        token: token,
        expires_at: expires_at.to_i,
        expires: false,
      }
    end

    # extra do
    #   {
    #     raw_info: {
    #       id: uid,
    #       name: name,
    #       first_name: first_name,
    #       last_name: last_name,
    #       link: link,
    #       nickname: nickname,
    #       location: { id: location_id, name: location_name },
    #       gender: gender,
    #       email: email,
    #       timezone: timezone,
    #       locale: locale,
    #       updated_time: updated_time.strftime("%FT%T%z")
    #     }
    #   }
    # end
  end
end
