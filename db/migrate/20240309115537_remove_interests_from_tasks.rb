class RemoveInterestsFromTasks < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :interests, :string
  end
end
