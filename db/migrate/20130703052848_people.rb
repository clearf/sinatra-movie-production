class People < ActiveRecord::Migration
  def up
    create_table :people do |t|
      t.string :name
      t.string :occupation
      t.timestamps
    end
  end
  def down
    drop_table :people
  end
end
