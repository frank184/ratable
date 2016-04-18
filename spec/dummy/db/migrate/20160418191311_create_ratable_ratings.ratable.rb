# This migration comes from ratable (originally 20160418175804)
class CreateRatableRatings < ActiveRecord::Migration
  def change
    create_table :ratable_ratings do |t|
      t.references :ratee, polymorphic: true
      t.references :rater, polymorphic: true
      t.integer :value
      t.text :comment

      t.timestamps null: false
    end
  end
end
