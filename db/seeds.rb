# frozen_string_literal: true

puts "Loading seeds..."

# Create Users
andy = User.find_or_create_by!(nick: "Andy", provider: "admin", provider_uid: "1", roles: [:admin])
user = User.find_or_create_by!(nick: "Andy", provider: "admin", provider_uid: "2")

# Create Competitions
competition = andy.competitions.create!(description: "First Competition", rating_method: "1", open_from: Time.zone.now, open_until: 7.days.from_now)

# Create Tasks
task = andy.tasks.create!(description: "Hello world", spec: "true", open_from: Time.zone.now, open_until: 7.days.from_now)

# Add task to competition
competition.add_task(task)

# Solution
solution = Solution.create!(competition: competition, task: task, code: "puts 'solved'")

# Add user to solution
solution.contestants.create!(user: andy)

# Create Invitations
Invitation.create!(creator: andy, invitee: user, entity: solution)

# Quick test:
puts "Solved tasks:"
ap andy.reload.solved_tasks
puts "Solvers:"
ap task.reload.solvers
