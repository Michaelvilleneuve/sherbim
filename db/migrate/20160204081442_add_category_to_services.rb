class AddCategoryToServices < ActiveRecord::Migration
  def change
    add_reference :services, :category, index: true, foreign_key: true
  end
end
