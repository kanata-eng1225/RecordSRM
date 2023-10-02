class UpdateNullPerformedInStressRecords < ActiveRecord::Migration[7.0]
  def up
    StressRecord.where(performed: nil).update_all(performed: false)
  end

  def down
  end
end
