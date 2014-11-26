class AddPriceTierCountsToSalesTracker < ActiveRecord::Migration
  def change
    add_column :sales_trackers, :single_tier_count, :integer, default: 0
    add_column :sales_trackers, :multiple_tier_count, :integer, default: 0
    add_column :sales_trackers, :extended_tier_count, :integer, default: 0
  end
end
