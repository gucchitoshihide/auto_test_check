# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

# report
require 'rubygems'
require 'ci/reporter/rake/test_unit' # use this if you're using Test::Unit

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


