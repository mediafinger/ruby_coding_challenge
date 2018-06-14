# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"
  belongs_to :entity, polymorphic: true

  INVITABLE_TYPES = %w(Competition Task Solution).freeze

  # record is the instance, attr the name 'Invitee'
  validates_each :entity do |record, attr, _entity|
    validates :entity_id, presence: true
    record.errors.add(attr, "must be one of #{INVITABLE_TYPES}") unless INVITABLE_TYPES.include?(record.entity_type)
  end

  validates_each :creator, on: :create do |record, _attr, creator|
    validates :creator, presence: true
    record.errors.add(:entity, "must be owned by creator") unless creator&.admin? ||
                                                                  record.entity.try(:users)&.include?(creator)
  end

  validates_each :invitee, on: :create do |record, attr, invitee|
    validates :invitee, presence: true
    record.errors.add(attr, "is already an owner of #{record.entity}") if record.entity.try(:users)&.include?(invitee)
  end

  def accept
    transaction do
      update!(answer: true, expires_at: Time.zone.now)
      send("accept_#{entity_type.to_s.downcase}")
      expire_all_duplicates
    end

    entity.reload.users
  end

  def decline
    update!(answer: false, expires_at: Time.zone.now)

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

  def expire_all_duplicates
    Invitation.where(invitee: invitee, entity: entity, answer: nil).each { |inv| inv.update(expires_at: Time.zone.now) }
  end
end
