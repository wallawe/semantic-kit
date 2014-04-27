class AddFieldsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :name,        :string
    add_column :themes, :description, :text
    add_column :themes, :copyright,   :string
  end
end
