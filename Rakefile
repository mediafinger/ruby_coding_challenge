# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

if %w(development test).include? Rails.env
  require "awesome_print"
  require "bundler/audit/task"
  require "rspec/core/rake_task"
  require "rubocop"

  Bundler::Audit::Task.new # rake bundle:audit
  RSpec::Core::RakeTask.new(:rspec)

  desc "Run rubocop"
  task rubocop: :environment do
    sh "bundle exec rubocop -c .rubocop.yml"
  end

  desc "Run rubocop with autocorrect"
  task rubocopa: :environment do
    puts "Obey the autocorrection cop!"
    sh "bundle exec rubocop -c .rubocop.yml --auto-correct"
  end

  desc "Run rubocop and the specs"
  task ci: %w(rubocop bundle:audit rspec)
end
