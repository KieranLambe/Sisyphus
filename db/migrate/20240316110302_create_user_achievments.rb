class CreateUserAchievments < ActiveRecord::Migration[7.1]
  def change
    create_table :user_achievments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achievment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
