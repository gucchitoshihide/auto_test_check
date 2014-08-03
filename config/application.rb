require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Las
  class Application < Rails::Application
    # http://qiita.com/somewhatgood@github/items/32b916ad91d556091d9d
    config.autoload_paths += %W(#{config.root}/app/models/logical)
    config.autoload_paths += %W(#{config.root}/app/models/physical)

    config.i18n.enforce_available_locales = true
    config.i18n.default_locale            = :ja
  end
end
