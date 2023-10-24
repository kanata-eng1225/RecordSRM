class StressRecord < ApplicationRecord
  # ストレスレベルの最小値
  STRESS_LEVEL_MIN = 0
  # ストレスレベルの最大値
  STRESS_LEVEL_MAX = 10
  # ストレスレベルのステップ
  STRESS_LEVEL_STEP = 1

  # 選択可能な最小の年
  START_YEAR = 2020
  # 月の範囲
  MONTH_RANGE = 1..12
  # 最初の週
  FIRST_WEEK_NUMBER = 1

  belongs_to :user

  validates :performed, inclusion: { in: [true, false] }
  validates :stress_relief_date, :before_stress_level, :after_stress_level, presence: true
  validates :before_stress_level, inclusion: { in: STRESS_LEVEL_MIN..STRESS_LEVEL_MAX }
  validates :after_stress_level, inclusion: { in: STRESS_LEVEL_MIN..STRESS_LEVEL_MAX }
  validates :title, length: { maximum: 50 }

  scope :for_date_range, ->(start_date, end_date) { where(stress_relief_date: start_date..end_date) }

  # 指定の日付範囲のストレスレベルのデータを取得
  def self.get_data_for_range(records, range, start_date)
    # 最新のストレス解消日を取得するか、存在しない場合は指定の開始日を使用
    latest_date = records.maximum(:stress_relief_date) || start_date

    # 表示範囲が週か月によって開始日を計算
    range_start_date = if range == 'week'
                         start_date
                       else
                         start_date.beginning_of_month
                       end

    # 指定の範囲内で、日ごとのストレスレベルの変動を計算
    records.where(stress_relief_date: range_start_date..latest_date)
           .group_by_day(:stress_relief_date, series: false)
           .sum('after_stress_level - before_stress_level')
  end

  # 指定の年月の各週の開始日と終了日を計算
  def self.calculate_weeks_for_month(year, month)
    first_day_of_month = Date.new(year, month, 1)
    last_day_of_month = first_day_of_month.end_of_month

    weeks = []
    start_day = first_day_of_month
    # 指定の月内で各週の開始日と終了日をリストアップ
    while start_day <= last_day_of_month
      end_day = [start_day.end_of_week(:sunday), last_day_of_month].min
      weeks << { start: start_day, end: end_day }
      start_day = end_day + 1.day
    end
    weeks
  end

  # 現在の日付がどの週に該当するかを特定
  def self.find_current_week_number(weeks, today)
    index = weeks.find_index { |week| week[:start] <= today && week[:end] >= today }
    index ? index + 1 : 1
  end
end
