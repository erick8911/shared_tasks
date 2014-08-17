module SharedTasks
  ##Extends de module after active record loads
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/shared_tasks.rake"
    end
  end
end
