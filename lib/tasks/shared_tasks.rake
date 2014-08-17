namespace :shared_tasks do

  #rake shared_tasks:tasks
  desc "Run shared tasks"
  task :tasks => :environment do
    SharedTasks::Task.run_tasks
  end

  #rake shared_tasks:task[file_name,task_name]
  desc "Run single task"
  task :task, [:file_name, :task_name] => :environment do |t, args|
    SharedTasks::Task.run_single_task(args.file_name, args.task_name)
  end

end
