class CreateSalesTrackers < ActiveRecord::Migration
  def change
    create_table :sales_trackers do |t|
      t.references :theme
      t.integer    :sale_count
      t.timestamps
    end
  end
end
