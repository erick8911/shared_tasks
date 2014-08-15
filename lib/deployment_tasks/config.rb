require 'singleton'
module DeploymentTasks
  # Class used to initialize configuration object.

  class Config
    include ::Singleton
    attr_accessor :table_name

    def initialize
      @table_name = "deployment_tasks"
    end
  end

end
