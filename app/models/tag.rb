class Tag < ApplicationRecord
  has_many :stress_relief_tags, dependent: :destroy
  has_many :stress_reliefs, through: :stress_relief_tags

  validates :name, presence: true
  validates :name, length: { maximum: 30 }
end
