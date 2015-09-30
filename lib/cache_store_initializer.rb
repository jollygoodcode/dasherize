class CacheStoreInitializer
  class << self
    def setup(config)
      # Used in config/application.rb
      options = { failover: true, socket_timeout: 1.5, socket_failure_delay: 0.2 }

      if ENV["REDISCLOUD_URL"].present?
        config.cache_store        = :redis_store, ENV["REDISCLOUD_URL"].split(","), options
        config.assets.cache_store = :redis_store, ENV["REDISCLOUD_URL"].split(","), options.merge(expires_in: 1.hour, race_condition_ttl: 5.second)
      else
        # Rails defaults to ActiveSupport::Cache::FileStore
      end
    end
  end
end
