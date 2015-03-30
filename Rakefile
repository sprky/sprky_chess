# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rubocop/rake_task'

Sprky::Application.load_tasks

RuboCop::RakeTask.new

task default: %w(test rubocop)
