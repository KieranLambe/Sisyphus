class CreateAchievments < ActiveRecord::Migration[7.1]
  def change
    create_table :achievments do |t|
      t.string :name
      t.text :description
      t.boolean :achieved, default: false
      t.string :condition

      t.timestamps
    end
  end
end
