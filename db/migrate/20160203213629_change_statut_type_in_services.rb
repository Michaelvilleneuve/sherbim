class ChangeStatutTypeInServices < ActiveRecord::Migration
  def up
    change_column :services, :statut, :string
  end

  def down
    change_column :services, :statut, :boolean
  end
end
