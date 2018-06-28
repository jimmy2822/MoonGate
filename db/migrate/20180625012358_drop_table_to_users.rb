class DropTableToUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :users
  end
end
