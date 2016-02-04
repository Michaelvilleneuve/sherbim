class FixTransactionsDefault < ActiveRecord::Migration
  def change
  	change_column :transactions, :done, :boolean, default: false
  end
end
