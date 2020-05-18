require_relative 'boot'

require "rails"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module LcsLottery
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
  end
end
