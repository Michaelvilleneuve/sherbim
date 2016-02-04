class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :debit
      t.integer :receive
      t.float :amount
      t.references :service, index: true, foreign_key: true
      t.boolean :status

      t.timestamps null: false
    end
  end
end
