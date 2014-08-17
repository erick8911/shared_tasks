require 'rails/generators'

module SharedTasks
  module Generators
    class SharedTaskGenerator < Rails::Generators::NamedBase
      #rails g shared_task file_name
      desc "Creates a file for a shared task"
      def create_initializer_file
        verify_name
        number = ActiveRecord::Migration.next_migration_number(1)
        full_name = "#{number}_#{file_name.underscore}"
        puts "Generating file #{full_name}"
        create_file "lib/shared_tasks/#{full_name}.rb", file_content
      end


      private

        def file_content
%(class #{file_name.camelize}Shared

  class << self
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
          route = "#{Rails.root}/lib/shared_tasks"
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
