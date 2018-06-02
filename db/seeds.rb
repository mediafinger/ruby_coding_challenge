# frozen_string_literal: true

puts "Loading seeds..."

# Create Users
andy = User.create!(nick: "Andy", provider: "admin", provider_uid: "1", roles: [:admin])
user = User.create!(nick: "Andy", provider: "admin", provider_uid: "2")

# Create RatingMethod and RatingAggregator
rating_aggregator = RatingAggregator.create!(user: andy, code: "1", description: "NotImplemented")
rating_method = RatingMethod.create!(user: andy, code: "1", description: "NotImplemented")

# Create Challenges
challenge_1 = andy.challenges.create!(description: "First Challenge", open_from: Time.zone.now, open_until: 7.days.from_now, rating_aggregator: rating_aggregator)

# Create Tasks
task = Task.create!(user: andy, challenge: challenge_1, description: "Hello world", open_from: Time.zone.now, open_until: 7.days.from_now, rating_method: rating_method)

# Create Specs
spec = Spec.create!(user: andy, code: "1 == 1")

# Create Requirements
Requirement.create!(task: task, spec: spec)

# Solution
solution = Solution.create!(task: task, code: "puts 'solved'")
Contestant.create!(user: andy, solution: solution)

# Create Invitations
Invitation.create!(creator: andy, invitee: user, entity: solution)

# Quick test:
# puts "Solved tasks:"
# ap andy.reload.solved_tasks
# puts "Solvers:"
# ap task.reload.solvers
