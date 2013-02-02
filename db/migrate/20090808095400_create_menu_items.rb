class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.date :date
      t.string :name
      t.string :meal_category_id                      # for statistical purposes
      t.integer :sort_order                           # copied from meal_category.sort_order
      t.decimal :price, :precision => 4, :scale => 2  # copied from meal_category.price
      
      t.timestamps
    end
    
  end
  
  def self.down
    drop_table :menu_items
  end
end
