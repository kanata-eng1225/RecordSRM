class Like < ApplicationRecord
  belongs_to :user
  belongs_to :stress_relief

  validates :user_id, uniqueness: { scope: :stress_relief_id }
end
