class RenameAchievements < ActiveRecord::Migration[7.1]
  def change
    rename_table :achievments, :achievements
  end
end
