class AddUserIdToGates < ActiveRecord::Migration[5.2]
  def change
    add_column :gates, :user_id, :integer
  end
end
