class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stress_reliefs
  has_many :likes, dependent: :destroy
  has_many :liked_stress_reliefs, through: :likes, source: :stress_relief
end
