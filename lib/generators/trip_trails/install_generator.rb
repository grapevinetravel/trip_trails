# frozen_string_literal: true

require 'rails/generators/base'
require 'rails/generators/migration'

module TripTrails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __dir__)

      # Implement the required interface for Rails::Generators::Migration.
      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      desc 'Copy migrations to your application.'
      def copy_migrations
        migration_template 'create_trip_trails_tables.rb',
                           'db/migrate/create_trip_trails_tables.rb'
      end
    end
  end
end
