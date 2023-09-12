class StressRecord < ApplicationRecord
  belongs_to :user

  STRESS_LEVEL_MIN = 0
  STRESS_LEVEL_MAX = 10
  STRESS_LEVEL_STEP = 1
end
