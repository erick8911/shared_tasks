require 'singleton'
module SharedTasks
  # Class used to initialize configuration object.

  class Config
    include ::Singleton
    attr_accessor :table_name

    def initialize
      @table_name = "shared_tasks"
    end
  end

end
