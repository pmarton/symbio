class CreateFinancialTransactions < ActiveRecord::Migration
  def change
    create_table :financial_transactions do |t|
      t.datetime :datetime
      t.integer :user_id
      t.decimal :amount, :precision => 5, :scale => 2
      t.string :comment
    end
    add_column :users, :balance, :decimal, :precision => 5, :scale => 2
  end
end
