# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'ci/reporter/rake/rspec'

Rails.application.load_tasks

namespace :test do
  desc 'prepare test'
  task :prepare do
    %x(cp config/settings/development.yml config/settings/test.yml)
  end
end

namespace :uploader do
  desc 'clean uploader'
  task :clean do
    %x(rm -rf public/uploads/user/avatar/[0-9]*)
  end
end
