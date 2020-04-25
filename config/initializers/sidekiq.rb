# frozen_string_literal: true

require 'sidekiq'
require 'hiredis'

redis_config = {
  url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0' },
  driver: 'hiredis'
}

Sidekiq.configure_client do |config|
  config.redis = redis_config.dup
end

Sidekiq.configure_server do |config|
  config.redis = redis_config.dup
  config.log_formatter = Sidekiq::Logger::Formatters::JSON.new
end

ActiveJob::Base.queue_adapter = :sidekiq if defined?(ActiveJob)
