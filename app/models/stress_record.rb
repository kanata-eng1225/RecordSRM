class StressRecord < ApplicationRecord
  belongs_to :user

  STRESS_LEVEL_MIN = 0
  STRESS_LEVEL_MAX = 10
  STRESS_LEVEL_STEP = 1

  def self.get_data_for_range(records, range)
    latest_date = records.maximum(:stress_relief_date)
    
    return {} unless latest_date

    start_date = if range == "week"
                   latest_date - 6.days
                 else
                   latest_date - 1.month + 1.day
                 end

    records.where(stress_relief_date: start_date..latest_date)
           .group_by_day(:stress_relief_date, default_value: nil)
           .sum("after_stress_level - before_stress_level")
  end
end
