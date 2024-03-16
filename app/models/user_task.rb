class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :task, uniqueness: true
end
