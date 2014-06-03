class AddPriceToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :price_tier, :decimal, scale: 2, precision: 5
  end
end
