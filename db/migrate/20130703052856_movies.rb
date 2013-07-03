class Movies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :movie_name
      t.integer :release_date
      t.string :director
      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
