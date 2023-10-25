class StressRelief < ApplicationRecord
  # 難易度の初期値
  DEFAULT_DIFFICULTY = 1
  # 難易度の最小値
  MIN_DIFFICULTY = 1
  # 難易度の最大値
  MAX_DIFFICULTY = 3

  belongs_to :user
  has_many :stress_relief_tags, dependent: :destroy
  has_many :tags, through: :stress_relief_tags
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :detail, presence: true
  validates :difficulty, presence: true, inclusion: { in: MIN_DIFFICULTY..MAX_DIFFICULTY }
  validate :check_for_invalid_tags

  # タグ名を配列で取得
  def tag_names
    # 一時保存されたタグ名があればそれを使用し、なければタグ名を取得する。
    @raw_tag_names.present? ? @raw_tag_names.split(',').map(&:strip) : tags.map(&:name)
  end

  # タグ名を設定する。既存のタグは再利用し、存在しないタグは新規作成する。
  def tag_names=(names)
    # 受け取ったタグ名を一時保存
    @raw_tag_names = names.strip
    tag_objects = []
    @invalid_tag_detected = false

    process_tags(names.split(',').compact_blank.uniq, tag_objects)

    # 無効なタグがない場合、タグを設定
    self.tags = tag_objects unless @invalid_tag_detected
  end

  # タグ名の配列を受け取り、それに対応するタグオブジェクトを取得または新規作成する。
  def process_tags(names_array, tag_objects)
    names_array.each do |name|
      tag = Tag.find_or_initialize_by(name: name) # rubocop:disable Style/HashSyntax
      if tag.new_record? && !tag.valid?
        errors.add(:tag_names, tag.errors.full_messages.join(', '))
        @invalid_tag_detected = true
      else
        tag.save
        tag_objects << tag
      end
    end
  end

  # 無効なタグがある場合、エラーを追加
  def check_for_invalid_tags
    return unless @invalid_tag_detected

    errors.add(:base, :invalid_tags)
  end

  # いいねをしているかどうかを確認する。
  def liked_by?(like, user)
    like.pluck(:user_id).include?(user)
  end

  # いいねのレコードを返す。
  def user_like(user)
    likes.find_by(user_id: user.id)
  end
end
