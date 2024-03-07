class Interest < ApplicationRecord
  has_many :user_interests
  has_many :users, through: :user_interests
  has_many :interest_tasks
  has_many :tasks, through: :interest_tasks
end
