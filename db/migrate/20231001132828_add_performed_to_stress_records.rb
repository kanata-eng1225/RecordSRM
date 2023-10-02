class AddPerformedToStressRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :stress_records, :performed, :boolean
  end
end
