class CreateInvoiceItems < ActiveRecord::Migration
  def self.up
    create_table :invoice_items do |t|
      t.date :date
      t.integer :user_id
      t.decimal :price, :precision => 4, :scale => 2
      t.decimal :rebate, :precision => 4, :scale => 2

      t.timestamps
    end
    add_column :orders, :invoice_item_id, :integer            
  end

  def self.down
    drop_table :invoice_items
    remove_column :orders, :invoice_item_id
  end
end
