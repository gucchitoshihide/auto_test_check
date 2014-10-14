ENV['RAILS_ENV'] ||= 'test'

require 'database_cleaner'
require 'factory_girl_rails'
require 'capybara/rspec'

require File.expand_path('../../config/environment', __FILE__)

# load support files
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# load related turnip files
Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }

# http://qiita.com/msk_tak/items/ded35722b9f22d02d988
# http://stackoverflow.com/questions/17666623/running-capybara-without-rack-produces-errors-when-using-url-parameters
Capybara.configure do |config|
  config.run_server     = false
  config.default_driver = :selenium
  config.app_host       = 'http://0.0.0:3000'
end

# initialize before run
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.configure do |config|
  # FactoryGirl module
  config.include FactoryGirl::Syntax::Methods 

  # Capybara settings
  config.include Capybara::DSL

  # config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
end
