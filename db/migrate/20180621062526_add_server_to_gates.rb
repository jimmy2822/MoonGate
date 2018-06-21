class AddServerToGates < ActiveRecord::Migration[5.2]
  def change
    add_column :gates, :server, :string
  end
end
