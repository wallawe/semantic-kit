class AddMissingThemeFields < ActiveRecord::Migration
  def change
    add_column :themes, :preprocessor, :string
    add_column :themes, :browsers,     :string, array: true, default: []
  end
end
