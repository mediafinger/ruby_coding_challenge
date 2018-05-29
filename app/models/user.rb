# frozen_string_literal: true

class User < ApplicationRecord
  validates :nick,         presence: true
  validates :provider,     presence: true
  validates :provider_uid, presence: true

  def self.find_or_create_from(auth)
    where(provider: auth[:provider], provider_uid: auth[:uid]).first_or_initialize.tap do |user|
      user.email        = auth.dig(:info, :email)
      user.name         = auth.dig(:info, :name)
      user.nick         = auth.dig(:info, :nickname)
      user.image        = auth.dig(:info, :image)
      user.url          = auth.dig(:info, :urls, :Blog) || auth.dig(:info, :urls, :GitHub)
      user.provider     = auth[:provider]
      user.provider_uid = auth[:uid]

      user.save!
    end
  end

  def name_or_nick
    name || nick
  end
end
