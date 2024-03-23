class UserTask < ApplicationRecord
  # LIMIT = 5

  # validate_on_create.validate_quota

  # def validate_quota
  #   return unless current_user

  #   if current_user.user_tasks(:reload).count >= LIMIT
  #     errors.add(:base, :exceeded_quota)
  #   end
  # end

  belongs_to :user
  belongs_to :task

  validates_associated :user
end
