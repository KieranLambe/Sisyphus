class RemoveConditionFromAchievements < ActiveRecord::Migration[7.1]
  def change
    remove_column :achievements, :condition, :string
  end
end
