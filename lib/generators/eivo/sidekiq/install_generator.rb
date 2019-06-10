# frozen_string_literal: true

require 'rails/generators'

module EIVO
  module Sidekiq
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def self.namespace(name = nil)
        @namespace ||= super.sub('e_i_v_o', 'eivo')
      end

      def create_initializer_file
        copy_file 'config/sidekiq.yml'
        copy_file 'app/jobs/application_job.rb'

        restart_code = <<-'EOF'
### EIVO Sidekiq begin ###

bundle exec sidekiqctl stop tmp/pids/sidekiq.pid 120
bundle exec sidekiq -C config/sidekiq.yml

### EIVO Sidekiq end ###
EOF

        stop_code = <<-'EOF'
### EIVO Sidekiq begin ###

bundle exec sidekiqctl stop tmp/pids/sidekiq.pid 15

### EIVO Sidekiq end ###
EOF

        # Remove old code if present
        regexp = /\n### EIVO Sidekiq begin ###.*### EIVO Sidekiq end ###/m
        gsub_file 'restart_production.sh', regexp, ''
        gsub_file 'restart_staging.sh', regexp, ''
        gsub_file 'stop_production.sh', regexp, ''
        gsub_file 'stop_staging.sh', regexp, ''

        # Inject new code
        after = "### EIVO end ###\n"
        inject_into_file 'restart_production.sh', restart_code, after: after
        inject_into_file 'restart_staging.sh', restart_code, after: after
        inject_into_file 'stop_production.sh', stop_code, after: after
        inject_into_file 'stop_staging.sh', stop_code, after: after

        append_to_file 'Procfile', "worker: bundle exec sidekiq -C config/sidekiq.yml\n"
        append_to_file '.env.example', "SIDEKIQ_THREADS=\"5\"\n"
        gsub_file '.env.example', /^DB_POOL="(\d+)".*/, 'DB_POOL="\1" # [RAILS_MAX_THREADS, SIDEKIQ_THREADS].max'
      end

    end
  end
end
