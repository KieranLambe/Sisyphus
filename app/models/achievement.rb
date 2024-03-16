class Achievement < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :condition, presence: true, uniqueness: true

  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements
end
