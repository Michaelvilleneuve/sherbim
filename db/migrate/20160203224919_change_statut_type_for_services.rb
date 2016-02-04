class ChangeStatutTypeForServices < ActiveRecord::Migration
  def change
	change_column :services, :statut, 'boolean USING CAST(statut AS boolean)'
  end
end
