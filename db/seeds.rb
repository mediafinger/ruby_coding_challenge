# frozen_string_literal: true

puts "Loading seeds..."

open_times = { open_from: Time.zone.now, open_until: 7.days.from_now }.freeze

# Create Users
andy = User.find_or_create_by!(nick: "Andy", provider: "admin", provider_uid: "1", roles: [:admin])
user = User.find_or_create_by!(nick: "Andy", provider: "admin", provider_uid: "2")

# Create Competitions
andy.transaction do
  @competition = Competition.create!({ description: "First Competition", rating_method: "1" }.merge(open_times))
  @competition.add_organizer(andy)
end

# Create Tasks
task = andy.tasks.create!({ description: "Hello world", spec: "true" }.merge(open_times))

# Add task to competition
@competition.add_task(task)

# Solution
solution = Solution.create!(competition: @competition, task: task, code: "puts 'solved'")

# Add user to solution
solution.contestants.create!(user: andy)

# Create Invitations
Invitation.create!(creator: andy, invitee: user, entity: solution)

# Quick test:
puts "Solved tasks:"
ap andy.reload.solved_tasks
puts "Solvers:"
ap task.reload.solvers
