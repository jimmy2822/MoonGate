class UpdateGateIntroDetailToText < ActiveRecord::Migration[5.2]
  def change
    change_column :gates, :intro_detail, :text
  end
end
