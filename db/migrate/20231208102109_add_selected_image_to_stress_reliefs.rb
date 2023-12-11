class AddSelectedImageToStressReliefs < ActiveRecord::Migration[7.0]
  def change
    add_column :stress_reliefs, :selected_image, :string
  end
end
