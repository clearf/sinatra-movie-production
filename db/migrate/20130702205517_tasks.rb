class Tasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name
      t.string :descriptions
      t.references :movie
      t.references :contact
      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end

