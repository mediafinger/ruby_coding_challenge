# frozen_string_literal: true

class Competition < ApplicationRecord
  has_many :challenges
  has_many :trials, through: :challenges, source: :task
  has_many :organizers
  has_many :users, through: :organizers
  has_many :solutions
  has_many :tasks, through: :solutions

  validates :description, presence: true
  # validates :rating_method, presence: true
  validates :open_from, presence: true
  # validates :open_until, presence: true

  # user can be a User or a user_id
  def add_organizer(user)
    user_id = user.is_a?(User) ? user.id : user

    begin
      organizers.create!(user_id: user_id)
    rescue ActiveRecord::RecordNotUnique => e
      logger.info "#{e.class} - User #{user_id} is already an Organizer of Competition #{id}."
    rescue ActiveRecord::RecordInvalid => e
      logger.info "#{e.class} - User #{user.inspect} could not be found or is no user object."
    end

    organizers.reload
  end

  def add_task(task)
    challenges.create!(task: task)
  end
  alias add_trial add_task

  # use simple rating mechanism that removes all whitespaces and returns the number of characters
  def rate(code)
    rating_method.present? ? rating_method.call(code) : code.gsub(/\s+/, "").length
  end
end
