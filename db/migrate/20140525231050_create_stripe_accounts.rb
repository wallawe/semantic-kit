class CreateStripeAccounts < ActiveRecord::Migration
  def change
    create_table :stripe_accounts do |t|
      t.references :user
      t.string     :recipient_id
      t.string     :payment_type
      t.timestamps
    end
  end
end
