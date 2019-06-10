# frozen_string_literal: true

require 'sidekiq'
require 'redis-namespace'
require 'hiredis'

redis_config = {
  url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0' },
  namespace: "#{Rails.application.class.parent_name.parameterize}-#{Rails.env}",
  driver: 'hiredis'
}

Sidekiq.configure_client do |config|
  config.redis = redis_config.dup
end

Sidekiq.configure_server do |config|
  config.redis = redis_config.dup
end

ActiveJob::Base.queue_adapter = :sidekiq if defined?(ActiveJob)
