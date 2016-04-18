class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :model_id
      t.string :model_type
      t.integer :value
      t.text :comment

      t.timestamps null: false
    end
  end
end
