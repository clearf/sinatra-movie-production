class CreateTasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :task_name
      t.string :description

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
