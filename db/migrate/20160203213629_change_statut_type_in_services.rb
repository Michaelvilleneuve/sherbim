class ChangeStatutTypeInServices < ActiveRecord::Migration
  def change
    change_column :services, :statut, :boolean
  end
end
