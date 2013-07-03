class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :movie_name
      t.integer :release
      t.string :director

      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end