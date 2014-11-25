class RemoveCopyrightFromThemes < ActiveRecord::Migration
  def change
    remove_column :themes, :copyright, :string
  end
end
