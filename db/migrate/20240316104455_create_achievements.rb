class CreateAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.boolean :achieved, default: false
      t.string :condition

      t.timestamps
    end
  end
end
