class CreateLikeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :like_logs do |t|
      t.references :gate

      t.timestamps
    end
  end
end
