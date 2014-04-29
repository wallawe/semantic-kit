class AddFieldsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :image, :string
    add_column :themes, :preview_url, :string
  end
end
