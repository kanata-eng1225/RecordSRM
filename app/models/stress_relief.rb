class StressRelief < ApplicationRecord
  belongs_to :user
  has_many :stress_relief_tags, dependent: :destroy
  has_many :tags, through: :stress_relief_tags
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  # 難易度の最大値
  MAX_DIFFICULTY = 3
  
  # 難易度の初期値
  DEFAULT_DIFFICULTY = 1

  # タグ名を配列にする。
  def tag_names
    tags.map(&:name)
  end

  # タグ名をカンマで分割して、データベースに存在しない場合は新しくタグを作成する。
  def tag_names=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  # いいねをしているかどうかを確認する。
  def liked_by?(like, user)
    # likes.where(user_id: user.id).exists?
    # likes.any? { |like| like.user_id == user.id }
    like.pluck(:user_id).include?(user)
    # likes.exists?(user_id: user.id)
    # likes.pluck(:user_id).include?(user.id)
  end

  # いいねのレコードを返す。
  def user_like(user)
    likes.find_by(user_id: user.id)
  end
end
