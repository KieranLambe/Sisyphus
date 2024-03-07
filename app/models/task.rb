class Task < ApplicationRecord
  has_many :interest_tasks
  has_many :interests, through: :interest_tasks
  has_many :user_tasks
  has_many :users, through: :user_tasks
end
