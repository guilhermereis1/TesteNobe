require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end

module Testenobe
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.default_locale = :"pt-BR"

    Time.zone = "America/Sao_Paulo"
    config.time_zone = "America/Sao_Paulo"
    ActiveRecord::Base.default_timezone = :utc
  end
end
