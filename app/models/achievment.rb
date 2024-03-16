class Achievment < ApplicationRecord
  validation :name, presence: true, uniqueness: true
  validation :description, presence: true, uniqueness: true
  validation :condition, presence: true, uniqueness: true

  has_many :user_achievments, dependent: :destroy
  has_many :users, through: :user_achievments
end
