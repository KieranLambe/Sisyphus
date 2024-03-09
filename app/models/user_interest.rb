class UserInterest < ApplicationRecord
  belongs_to :user_id
  belongs_to :interest_id
end
