class FixTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :debitor_id, :integer
  	add_column :transactions, :receiver_id, :integer
  	remove_column :transactions, :debit
  	remove_column :transactions, :receive
  	add_column :transactions, :done, :boolean
  	remove_column :transactions, :status
  	remove_column :transactions, :amount
  end
end
