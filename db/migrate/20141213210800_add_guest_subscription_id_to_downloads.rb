class AddGuestSubscriptionIdToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :guest_subscription_id, :integer
  end
end
