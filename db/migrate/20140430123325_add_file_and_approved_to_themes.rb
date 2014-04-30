class AddFileAndApprovedToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :file_package, :string
    add_column :themes, :approved, :boolean, default: false
  end
end
