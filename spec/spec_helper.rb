require 'database_cleaner'
require 'factory_girl_rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# initialize before run
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.configure do |config|
  # FactoryGirl module
  config.include FactoryGirl::Syntax::Methods 

  # config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
end
