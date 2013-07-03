class CreateAddMovieIdAndTaskIdToPerson < ActiveRecord::Migration
  def up
      change_table :people do |t|
      # t.references :movie
      t.references :task
    end
  end

  def down
    remove_column :people, :movie_id
    remove_column :people, :task_id
  end
end

