class AddSubscriptionIdToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :subscription_id, :integer
  end
end
