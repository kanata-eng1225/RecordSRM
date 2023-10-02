class StressRecord < ApplicationRecord
  belongs_to :user

  validates :performed, inclusion: { in: [true, false] }

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

  # 指定された範囲のデータを取得する
  def self.get_data_for_range(records, range, start_date)
    # 最新のストレス解消日を取得、または開始日を使用
    latest_date = records.maximum(:stress_relief_date) || start_date
    
    # 表示範囲の開始日を計算
    range_start_date = if range == "week"
                         start_date
                       else
                         start_date.beginning_of_month
                       end

    # 指定された範囲のストレスレコードを日ごとにグループ化し、ストレスレベルの差を合計
    records.where(stress_relief_date: range_start_date..latest_date)
           .group_by_day(:stress_relief_date, series: false)
           .sum("after_stress_level - before_stress_level")
  end
end
