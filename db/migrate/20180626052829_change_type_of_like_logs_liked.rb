class ChangeTypeOfLikeLogsLiked < ActiveRecord::Migration[5.2]
  def change
    change_column :like_logs, :who_liked, 'integer USING who_liked::integer'
  end
end