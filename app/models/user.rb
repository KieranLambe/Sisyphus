class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
end
