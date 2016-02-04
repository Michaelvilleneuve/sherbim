class RemoveReceiverFromTransactions < ActiveRecord::Migration
  def change
  	remove_column :transactions, :debitor_id
  	remove_column :transactions, :receiver_id
  	add_column :transactions, :worker_id, :integer
  end
end
