require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require File.expand_path('../../lib/cache_store_initializer', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dasherize
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Dynamic Error Pages
    # http://wearestac.com/blog/dynamic-error-pages-in-rails
    config.exceptions_app = self.routes

    # Sending Mail
    config.action_mailer.default_url_options = { host: ENV['WWW_HOSTNAME'] }

    # Additional Assets
    # config.assets.precompile += %w( admin.css admin.js )

    # https://github.com/cyu/rack-cors
    # Note that this might still not work as static files are usually served from the web server
    config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
      allow do
        origins ENV['WWW_HOSTNAME']
        resource '/assets/*', :headers => :any, :methods => [:head, :get, :options]
      end
    end

    CacheStoreInitializer.setup(config)
  end
end
