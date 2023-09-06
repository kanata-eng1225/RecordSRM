class CreateStressReliefTags < ActiveRecord::Migration[7.0]
  def change
    create_table :stress_relief_tags do |t|
      t.references :stress_relief, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :stress_relief_tags, [:stress_relief_id, :tag_id], unique: true
  end
end
