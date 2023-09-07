class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stress_relief, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:user_id, :stress_relief_id], unique: true
  end
end
