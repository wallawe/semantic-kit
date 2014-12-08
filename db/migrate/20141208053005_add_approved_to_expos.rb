class AddApprovedToExpos < ActiveRecord::Migration
  def change
    add_column :expos, :approved, :boolean, default: false
  end
end
