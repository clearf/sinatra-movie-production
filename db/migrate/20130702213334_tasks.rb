class Tasks < ActiveRecord::Migration
 def up
    create_table :tasks do |t|
      t.string :name
      t.string :due
      t.index :movie_id
      t.index :person_id

      t.timestamps
  end
end

  def down
    drop_table :movies
  end
end