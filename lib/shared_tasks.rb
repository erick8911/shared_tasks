require "shared_tasks/version"
require "shared_tasks/config"
require 'shared_tasks/railtie'  ##Esential!

Array.module_eval do
  def remove_last(n = 1)
    self.first(self.size - n)
  end
end


module SharedTasks
  # Your code goes here...

  class << self
    def config
      @@config ||= SharedTasks::Config.instance
    end
  end

  class Task < ::ActiveRecord::Base
    self.table_name = SharedTasks.config.table_name
    before_destroy :rollback_actions


    def rollback_actions
      @file = Dir.entries(route).select {|f| !File.directory?(f) && f.include?(self.task) }.first
      if @file && File.exist?(file_route)
        load_file
        run_task("destroy_actions")
      else
        message = "There isnt a file with name given - destroying data"
        puts message.center(100, ".")
      end
    end

    private
      def route
        "lib/shared_tasks"
      end

      def file_route
        "lib/shared_tasks/#{@file}"
      end

      def load_file
        load(file_route)
      end

      def file_name
        @file.split("_").drop(1).join("_").split(".").remove_last.first
      end

      def run_task(task = file_name)
        class_name = "#{file_name.camelize}Shared".constantize
        task_to_run = "#{class_name}.#{task}"
        puts ".......#{@file}..=> #{task_to_run}......"
        eval(task_to_run)
      end


    public

      class << self




        def run_tasks
          puts "Running shared tasks"
          files = Dir.entries(route).select {|f| !File.directory?(f)}
          files.each do |file|
            @file = file
            SharedTasks::Task.where(task: file_date).first_or_create do
              load_and_run_task if File.exist?(file_route)
            end
          end
        end


        def run_single_task(name, task)
          @file = Dir.entries(route).select {|f| (!File.directory?(f) && f.include?("#{name}")) }.first
          if @file && File.exist?(file_route)
            load_and_run_task(task)
          else
            message = "There isnt a file with name given"
            puts message.center(100, ".")
            raise message
          end
        end

        def load_and_run_task(task = file_name)
          load_file
          run_task(task)
        end

        def load_file
          load(file_route)
        end

        def run_task(task = file_name)
          class_name = "#{file_name.camelize}Shared".constantize
          if task == file_name
            class_name.methods(false).each do |metad|
              if metad != :destroy_actions && metad != :_validators
                puts "Running => " + metad.to_s
                eval("#{class_name}.#{metad.to_s}")
              end
            end
          else
            if class_name.methods(false).include?(task.to_sym)
              puts "Running single task"
              eval("#{class_name}.#{task}")
            else
              raise "There isnt a task with name given => #{class_name}.#{task} "
            end
          end
        end

        def route
          "lib/shared_tasks"
        end

        def file_route
          "lib/shared_tasks/#{@file}"
        end

        def file_name
          @file.split("_").drop(1).join("_").split(".").remove_last.first
        end

        def file_date
          @file.split("_").shift
        end

      end
    #/Public
  end

end
