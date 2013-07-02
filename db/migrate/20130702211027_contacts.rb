class Contacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :contacts
  end
end
