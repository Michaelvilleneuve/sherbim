class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :firstname
      t.text :description
      t.string :email
      t.string :phone
      t.int :age
      t.float :points

      t.timestamps null: false
    end
  end
end
