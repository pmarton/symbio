class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.date :date
      t.integer :user_id
      t.integer :menu_item_id
      t.integer :meal_category_id
      t.string :state, :null => :no, :default => 'new'

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
