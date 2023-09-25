class AddNotNullToStressReliefs < ActiveRecord::Migration[7.0]
  def change
    change_column_null :stress_reliefs, :title, false
    change_column_null :stress_reliefs, :detail, false
    change_column_null :stress_reliefs, :difficulty, false
  end
end
