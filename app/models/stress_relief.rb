class StressRelief < ApplicationRecord
  belongs_to :user
  has_many :stress_relief_tags, dependent: :destroy
  has_many :tags, through: :stress_relief_tags

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
end
