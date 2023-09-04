class StressRelief < ApplicationRecord
  belongs_to :user

  MAX_DIFFICULTY = 3
  DEFAULT_DIFFICULTY = 1
end
