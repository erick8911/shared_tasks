namespace :deployment do

  #rake db:deployment_tasks # Run not executed tasks
  desc "Run deployment tasks"
  task :deployment_tasks => :environment do
    DeploymentTask.run_tasks
  end

  #rake db:deployment_task file_name method_name # Run specific task (Overide)
  desc "Run deployment tasks"
  task :deployment_task, [:name, :task] => :environment do |t, args|
    DeploymentTask.run_single_task(args.name, args.task)
  end

end
