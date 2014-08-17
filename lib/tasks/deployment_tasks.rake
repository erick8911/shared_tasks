namespace :deployment do

  #rake deployment:deployment_tasks
  desc "Run deployment tasks"
  task :deployment_tasks => :environment do
    DeploymentTasks::Task.run_tasks
  end

  #rake deployment:deployment_task[file_name,task_name]
  desc "Run deployment tasks"
  task :deployment_task, [:file_name, :task_name] => :environment do |t, args|
    DeploymentTasks::Task.run_single_task(args.file_name, args.task_name)
  end

end
