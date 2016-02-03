class AddLongitudeAndLatitudeToServices < ActiveRecord::Migration
  def change
    add_column :services, :longitude, :string
    add_column :services, :latitude, :string
  end
end
