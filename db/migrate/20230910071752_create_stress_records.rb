class CreateStressRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :stress_records do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :stress_relief_date, null: false
      t.string :title
      t.text :detail
      t.integer :before_stress_level
      t.integer :after_stress_level
      t.text :impression

      t.timestamps
    end
  end
end
