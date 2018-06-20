class CreateGates < ActiveRecord::Migration[5.2]
  def change
    create_table :gates do |t|
      t.string :name
      t.string :icon
      t.string :tag
      t.text :intro
      t.string :intro_detail
      t.boolean :is_public

      t.timestamps
    end
  end
end
