class DropTableToAdmins < ActiveRecord::Migration[5.2]
  def change
    drop_table :admins, if_exists: true
  end
end
