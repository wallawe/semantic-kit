class CreateGuestSubscriptions < ActiveRecord::Migration
  def change
    create_table :guest_subscriptions do |t|
      t.references :theme
      t.string  :token
      t.string  :email
      t.decimal :price_tier, scale: 2, precision: 5

      t.timestamps
    end
  end
end
