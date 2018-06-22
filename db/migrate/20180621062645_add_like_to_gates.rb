class AddLikeToGates < ActiveRecord::Migration[5.2]
  def change
    add_column :gates, :like, :integer ,default:0
  end
end
