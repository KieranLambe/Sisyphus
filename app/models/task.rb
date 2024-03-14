class Task < ApplicationRecord
  include PgSearch::Model

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  has_many :interest_tasks
  has_many :interests, through: :interest_tasks, dependent: :destroy
  has_many :user_tasks
  has_many :users, through: :user_tasks

  pg_search_scope :global_search,
    against: [:title, :description],
    associated_against: {
      interests: [:title]
    },
    using: {
      tsearch: { prefix: true }
    }
end
