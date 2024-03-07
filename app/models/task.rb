class Task < ApplicationRecord
  has_many :interest_tasks
  has_many :interests, through: :interest_tasks
end
