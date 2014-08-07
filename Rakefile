# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :test do
  desc 'prepare test'
  task :prepare do
    %x(cp config/settings/development.yml config/settings/test.yml)
  end
end
