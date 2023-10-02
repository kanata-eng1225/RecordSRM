class AddNotNullConstraintsToStressRecords < ActiveRecord::Migration[7.0]
  def change
    change_column_default :stress_records, :performed, false
    change_column_null :stress_records, :performed, false
    change_column_null :stress_records, :before_stress_level, false
    change_column_null :stress_records, :after_stress_level, false
  end
end
