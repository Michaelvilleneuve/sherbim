class AddNbpartToServices < ActiveRecord::Migration
  def change
    add_column :services, :nbpart, :integer
  end
end
