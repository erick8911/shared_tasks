class CreateDeploymentTasks < ActiveRecord::Migration
  def change
    create_table :deployment_tasks do |t|
      t.string :task
      t.timestamps
    end
  end
end
