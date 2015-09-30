workers Integer(ENV["WEB_CONCURRENCY"]|| 2)
threads Integer(ENV.fetch("WEB_MAX_THREADS", 5)), Integer(ENV.fetch("WEB_MAX_THREADS", 5))

preload_app!

rackup      DefaultRackup
port ENV.fetch("PORT", 3000)
environment ENV.fetch("RACK_ENV", "development")

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot

  ActiveRecord::Base.establish_connection

  Rails.cache.reconnect if Rails.cache.respond_to?(:reconnect)
end
