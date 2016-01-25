source "https://rubygems.org"

ruby "2.3.0"

gem "rails", "4.2.5"

# Server and Database
gem "puma"
gem "pg"

# HTML, CSS and JavaScript Stack
gem "slim-rails"
gem "sass-rails"
gem "uglifier"
gem "coffee-rails"
gem "jquery-rails"
gem "turbolinks", github: "rails/turbolinks"
gem "jquery-turbolinks"

gem "materialize-sass"
gem "font-awesome-sass"

gem "http"
gem "rack-cors", require: "rack/cors" # CORS for fonts through Cloudfront

# Cache
gem "dalli"
gem "redis-rails"
gem "redis", require: ["redis", "redis/connection/hiredis"]
gem "hiredis"

# App Specific
gem "devise"
gem "rolify"
gem "cancancan"

gem "simple_form"

gem "rails_utils"
gem "local_time"

gem "octokit"
gem "faraday-http-cache"
gem "codeship"
gem "parallel"

# Third party logins
gem "omniauth"
gem "omniauth-github"

group :staging, :production do
  gem "rails_12factor"
  gem "heroku-deflater"
  gem "newrelic_rpm"
end

group :staging do
  gem "recipient_interceptor"
end

group :development, :test do
  gem "dotenv-rails"
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "shoulda", require: false
  gem "factory_girl_rails"
  gem "faker"
  gem "capybara"
  gem "selenium-webdriver"
  gem "launchy"
  gem "email_spec"
end

group :development do
  # gem "spring"
  # gem "spring-commands-rspec"
  gem "quiet_assets"
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "bullet"
  gem "benchmark-ips"

  # Guards
  gem "guard-rspec", require: false
  gem "guard-livereload"
  gem "rack-livereload"
end

group :test do
  gem "database_rewinder"
  gem "webmock"
end

gem "nokogiri", ">= 1.6.7.1"
