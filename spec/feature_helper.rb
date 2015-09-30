require "rails_helper"

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseRewinder.strategy = :truncation
    DatabaseRewinder.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseRewinder.start
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end
end
