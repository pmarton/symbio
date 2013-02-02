class CreateMealCategories < ActiveRecord::Migration
  def self.up
    create_table :meal_categories do |t|
      t.string :name
      t.integer :sort_order
      t.decimal :price, :precision => 4, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :meal_categories
  end
end
