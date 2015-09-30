if Rails.env.development?
  class DisableAssetsLogger
    def initialize(app)
      @app = app
      Rails.application.assets.logger = Logger.new("/dev/null")
    end

    def call(env)
      previous_level = Rails.logger.level
      Rails.logger.level = Logger::ERROR if env["PATH_INFO"].index("/assets/") == 0 || env["PATH_INFO"].index("/system/") == 0
      @app.call(env)
    ensure
      Rails.logger.level = previous_level
    end
  end
  Rails.application.config.middleware.insert_before Rails::Rack::Logger, DisableAssetsLogger
end
