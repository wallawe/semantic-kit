class AddTitleToExpos < ActiveRecord::Migration
  def change
    add_column :expos, :title, :string
  end
end
