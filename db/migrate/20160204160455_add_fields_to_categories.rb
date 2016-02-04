class AddFieldsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :color, :string
    add_column :categories, :glyph, :string
  end
end
