class CreateInterestTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :interest_tasks do |t|
      t.references :interest, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
