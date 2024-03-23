class AddAchievedToUserAchievements < ActiveRecord::Migration[7.1]
  def change
    add_column :user_achievements, :achieved, :boolean, default: false
  end
end
