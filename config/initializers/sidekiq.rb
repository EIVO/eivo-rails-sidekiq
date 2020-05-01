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

  if Rails.env.staging? || Rails.env.production?
    config.log_formatter = ::EIVO::Formatter.new
  end
end

ActiveJob::Base.queue_adapter = :sidekiq if defined?(ActiveJob)
