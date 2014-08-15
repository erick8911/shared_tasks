require 'rails/generators'

module DeploymentTasks
  module Generators
    class DeploymentTaskGenerator < Rails::Generators::NamedBase
      #rails g deployment_task file_name
      desc "Creates a file for a deployment task"
      def create_initializer_file
        verify_name
        number = ActiveRecord::Migration.next_migration_number(1)
        full_name = "#{number}_#{file_name.underscore}"
        puts "Generating file #{full_name}"
        create_file "lib/deployment_tasks/#{full_name}.rb", file_content
      end


      private

        def file_content
    %(class #{file_name.camelize}Deployment


      class << self
        def #{file_name}
          #{file_name.camelize}Deployment.methods(false).each do |metad|
            if metad != :#{file_name} && metad != :destroy_actions
              puts "Running => " + metad.to_s
              eval(metad.to_s)
            end
          end
        end

        ################
        ##Code Goes Here
        ## def method_1
        ## end
        ##
        ## def method_2
        ## end
        ##Code
        ################

        def destroy_actions
          #Actions before destroy
        end


      end

    end
    )
        end

        def verify_name
          route = "#{Rails.root}/lib/deployment_tasks"
          files = Dir.entries(route).select {|f| !File.directory? f}.map{|f| f.split("_").drop(1).join("_").split(".").remove_last(1)}.flatten
          if files.include?("#{file_name}")
            message = "There is a file with same name. -Change file name-"
            puts message.center(100, ".")
            raise message
          end
        end

    end
  end
end
