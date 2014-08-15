require "deployment_tasks/version"
require "deployment_tasks/config"

module DeploymentTasks
  # Your code goes here...

  def self.config
    @@config ||= DeploymentTasks::Config.instance
  end

  class Task < ::ActiveRecord::Base
    self.table_name = DeploymentTasks.config.table_name
  end
end
