require 'rails/generators'

module DeploymentTasks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      desc "Generates tasks migration"

      # Commandline options can be defined here using Thor-like options:
      # class_option :my_opt, :type => :boolean, :default => false, :desc => "My Option"
      # I can later access that option using:
      # options[:my_opt]
      # Code goes here ;)
      # source_root File.expand_path("../templates", __FILE__)

      route_file =  File.join(File.dirname(__FILE__), "templates/")
      source_root route_file
      puts route_file

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def copy_migration
        migration_template 'migration.rb', "db/migrate/create_deployment_tasks"
        #copy_file "deployment_tasks", "lib"
        #FileUtils.cp_r( "/lib/deployment_tasks", "lib" )
      end

      # Generator Code. Remember this is just suped-up Thor so methods are executed in order
    end
  end
end
