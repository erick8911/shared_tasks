class CreateSharedTasks < ActiveRecord::Migration
  def change
    create_table :shared_tasks do |t|
      t.string :task
      t.timestamps
    end
  end
end
