class ChangeColumnNameServices < ActiveRecord::Migration
  def change
  	rename_column :services, :statut, :done
  end
end
