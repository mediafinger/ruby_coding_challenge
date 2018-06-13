# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"
  belongs_to :entity, polymorphic: true

  INVITABLE_TYPES = %w(Competition Task Solution).freeze

  validates :creator, presence: true
  validates :invitee, presence: true
  validates :entity, presence: true

  # record is the instance, attr the name 'entity', value is the entity
  validates_each :entity do |record, attr, value|
    if INVITABLE_TYPES.include?(record.entity_type)
      record.errors.add(attr, "must be owned by creator") unless
        value.users.include?(record.creator) || record.creator.admin?
    else
      record.errors.add(attr, "must be one of #{INVITABLE_TYPES}")
    end
  end

  def accept
    transaction do
      send("accept_#{entity_type.to_s.downcase}")
      update!(answer: true, expires_at: Time.now)
    end

    entity.reload.users
  end

  def decline
    update!(answer: false, expires_at: Time.now)

    entity.reload.users
  end

  private

  def accept_competition
    Competition.find(entity_id).organizers.create!(user_id: invitee_id)
  end

  def accept_task
    Task.find(entity_id).challengers.create!(user_id: invitee_id)
  end

  def accept_solution
    Solution.find(entity_id).contestants.create!(user_id: invitee_id)
  end
end
