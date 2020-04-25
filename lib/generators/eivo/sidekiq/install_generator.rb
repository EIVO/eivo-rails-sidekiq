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
        append_to_file 'Procfile', "worker: bundle exec sidekiq -C config/sidekiq.yml\n"
      end

    end
  end
end
