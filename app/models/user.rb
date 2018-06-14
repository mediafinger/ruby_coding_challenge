# frozen_string_literal: true

class User < ApplicationRecord
  has_many :organizers
  has_many :competitions, through: :organizers
  has_many :challengers
  has_many :tasks, through: :challengers
  has_many :contestants
  has_many :solutions, through: :contestants
  has_many :solved_tasks, through: :solutions, source: :task
  has_many :invitations, foreign_key: "creator_id"
  has_many :invitations, foreign_key: "invitee_id"

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

  def add_role(role)
    roles << role.to_s
    update!(roles: roles.uniq)
  end

  def admin?
    roles.include?("admin")
  end

  def nickname
    name || nick || email
  end
end
