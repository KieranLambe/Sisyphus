class RemoveAchivedFromAchievements < ActiveRecord::Migration[7.1]
  def change
    remove_column :achievements, :achieved, :boolean
  end
end
