Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.action_controller.asset_host = "http://#{ENV['WWW_HOSTNAME']}"

  # Custom Generators
  config.generators do |g|
    g.template_engine  :slim

    g.test_framework      :rspec, fixture: true
    g.fixture_replacement :factory_girl, dir: 'spec/factories'
    g.integration_tool    :rspec

    g.view_specs       false
    g.helper_specs     false
    g.request_specs    false
    g.routing_specs    false

    g.stylesheets      false
    g.javascripts      false
    g.assets           false
  end

  # Scaffold
  config.app_generators.scaffold_controller = :scaffold_controller

  # Rack Live Reload
  config.middleware.use Rack::LiveReload

  # Bullet Gem
  config.after_initialize do
    Bullet.enable         = false
    Bullet.alert          = false
    Bullet.bullet_logger  = false
    Bullet.console        = false
    Bullet.rails_logger   = false
    Bullet.add_footer     = false
  end
end
