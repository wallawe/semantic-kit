class CreateGuestDownloads < ActiveRecord::Migration
  def change
    create_table :guest_downloads do |t|
      t.references :guest_subscription
      t.references :theme
      t.timestamps
    end
  end
end
