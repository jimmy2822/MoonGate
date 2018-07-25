class DropTableToUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :users, if_exists: true
  end
end
