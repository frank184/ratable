class CreateRatableRatings < ActiveRecord::Migration
  def change
    create_table :ratable_ratings do |t|
      t.integer :model_id
      t.string :model_type
      t.integer :value
      t.text :comment

      t.timestamps null: false
    end
  end
end
