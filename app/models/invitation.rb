# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"
  belongs_to :entity, polymorphic: true

  def accept
    transaction do
      send("accept_#{entity_type}")
      update!(answer: true, expires_at: Time.now)
    end
  end

  def decline
    update!(answer: false, expires_at: Time.now)
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
