class CreateJoin < ActiveRecord::Migration
  def change
  	drop_table :participants
    create_join_table :services, :users
  end
end
