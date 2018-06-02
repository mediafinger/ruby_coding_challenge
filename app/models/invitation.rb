# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"
  belongs_to :entity, polymorphic: true
end
