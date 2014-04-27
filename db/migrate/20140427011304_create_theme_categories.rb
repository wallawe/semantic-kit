class CreateThemeCategories < ActiveRecord::Migration
  def change
    create_table :theme_categories do |t|
      t.references :category
      t.references :theme
      t.timestamps
    end
  end
end
