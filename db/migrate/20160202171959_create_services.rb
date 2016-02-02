class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :place
      t.string :transport
      t.string :statut
      t.float :price
      t.datetime :date
      t.string :code

      t.timestamps null: false
    end
  end
end
