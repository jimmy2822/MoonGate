class AddWhoLikedToLikeLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :like_logs, :who_liked, :string
  end
end
